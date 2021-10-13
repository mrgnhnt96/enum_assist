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
  }) : super(enumName, fields);

  /// The name of the method to call
  final String methodName;

  /// the value to be returned by the enum value
  final String? Function(EnumField) returnValue;

  /// the access method that will be used
  ///
  /// Options:
  /// - `map`
  /// - `maybeMap`
  final MethodType methodType;

  /// the default value to be returned by the enum value
  final String? defaultValue;

  /// the return type of the method
  ///
  /// (e.g. `'$String'` or `'String'`)
  final String typeAsString;

  String get _getAccess =>
      methodType.map(maybeMapMethod: 'maybeMap', mapMethod: 'map');

  bool get _useOrElse => methodType.map(maybeMapMethod: true, mapMethod: false);

  @protected
  @nonVirtual
  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    String? _checkValueAndPrepare(String? value, EnumField field) {
      if (value == '') {
        throw BadStringFormatException(field.wholeName, value!);
      }

      final formattedValue = value?.replaceAll(RegExp('\n'), r'\n');

      return _prepValueForGen(formattedValue);
    }

    buffer.writeobj(
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
  _Item convert(EnumField e) => _Item(enumName, e);

  String? _prepValueForGen(String? value) {
    if (typeAsString.startsWith('String') && value != null) {
      return "'$value'";
    }
    return value;
  }

  bool get _isTypeNullable {
    return typeAsString.contains('?');
  }
}
