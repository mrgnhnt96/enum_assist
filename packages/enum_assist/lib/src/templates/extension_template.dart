import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

class _Item extends FieldTemplate<EnumField> {
  const _Item(String enumName, EnumField field) : super(enumName, field);

  String returnString<T>(T value) => '$field: $value,';
}

/// {@template enum_assist.additional_template}
/// Helper class to create [ExtensionTemplate]s
/// {@endtemplate}
abstract class ExtensionTemplate extends TemplateCoreDetailed<_Item> {
  /// {@macro enum_assist.additional_template}
  ExtensionTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required this.defaultValue,
    required this.methodName,
    required this.returnValue,
    required this.methodType,
    required this.typeAsString,
    required this.docComment,
  }) : super(enumName, fields);

  /// The name of the method to call
  @protected
  final String methodName;

  /// the value to be returned by the enum value
  @protected
  final String? Function(EnumField) returnValue;

  /// the access method that will be used
  ///
  /// Options:
  /// - `map`
  /// - `maybeMap`
  @protected
  final MethodType methodType;

  /// the default value to be returned by the enum value
  @protected
  final String? defaultValue;

  /// the return type of the method
  ///
  /// (e.g. `'$String'` or `'String'`)
  @protected
  final String typeAsString;

  /// the doc comment for the method
  @protected
  final String docComment;

  String get _getAccess => methodType.map(maybeMap: 'maybeMap', map: 'map');

  bool get _useOrElse => methodType.map(maybeMap: true, map: false);

  @protected
  @nonVirtual
  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    String? _checkValueAndPrepare(String? value, EnumField field) {
      return prepValueForGen(value);
    }

    buffer
      ..writeln(docComment)
      ..writeobj(
        '$typeAsString get $methodName',
        body: (nameBuffer, tab) {
          nameBuffer.writeobj(
            'return $_getAccess',
            tab: tab,
            open: '(',
            close: ');',
            body: (mapBuffer, mapTab) {
              if (_useOrElse) {
                mapBuffer.writeln('orElse: $defaultValue,');
              }
              mapBuffer.writelnTab(
                map((i) {
                  final value = returnValue(i.field);
                  final preparedValue = _checkValueAndPrepare(value, i.field);

                  if (!_isTypeNullable && preparedValue == null) {
                    throw NullValueException(i.field.fieldName);
                  }

                  return tabn(i.returnString(preparedValue), tab);
                }),
                mapTab,
              );
            },
          );
        },
      );

    return buffer;
  }

  @override
  @protected
  _Item convert(EnumField e) => _Item(enumName, e);

  /// prepares the value for the generation
  ///
  /// if type is `String`, it will be wrapped in quotes
  String? prepValueForGen(String? value) {
    final formattedValue = value?.replaceAll(RegExp('\n'), r'\n');

    if (typeAsString.startsWith('String') && formattedValue != null) {
      return "'$formattedValue'";
    }
    return formattedValue;
  }

  bool get _isTypeNullable => isTypeAsStringNullable(typeAsString);
}
