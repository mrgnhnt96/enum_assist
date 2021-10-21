import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

/// when a value is unassigned, and has a default value in the constructor
const unassigned = '__unassigned__';

class _Item extends FieldTemplate<FieldData> {
  const _Item(String enumName, FieldData field) : super(enumName, field);

  String returnString<T>(T value) => '$field: $value,';
}

/// {@template enum_assist.additional_template}
/// Helper class to create [ExtensionTemplate]s
/// {@endtemplate}
abstract class ExtensionTemplate extends TemplateCoreDetailed<_Item> {
  /// {@macro enum_assist.additional_template}
  ExtensionTemplate(
    String enumName,
    Iterable<FieldData> fields, {
    required this.defaultValue,
    required this.methodName,
    required this.returnValue,
    required this.methodType,
    required this.typeAsString,
    required this.docComment,
    required this.allowNulls,
  }) : super(enumName, fields);

  /// The name of the method to call
  @protected
  final String methodName;

  /// the value to be returned by the enum value
  @protected
  final String? Function(FieldData) returnValue;

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

  /// whether or not to return null values
  @protected
  final bool allowNulls;

  String get _getAccess => methodType.map(maybeMap: 'maybeMap', map: 'map');

  bool get _useOrElse => methodType.map(maybeMap: true, map: false);

  @protected
  @nonVirtual
  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    String? _checkValueAndPrepare(String? value, FieldData field) {
      return prepValueForGen(value);
    }

    buffer
      ..writeln(docComment)
      ..writeobj(
        '$typeAsString${allowNulls ? '?' : ''} get $methodName',
        body: (nameBuffer, tab) {
          nameBuffer.writeobj(
            'return $_getAccess',
            tab: tab,
            open: '(',
            close: ');',
            body: (mapBuffer, mapTab) {
              if (_useOrElse) {
                mapBuffer
                  ..writelnTab('// returns default value', mapTab)
                  ..writelnTab(
                      '//? if theres a provided value, it does nothing.',
                      mapTab)
                  ..writeln('orElse: $defaultValue${allowNulls ? '' : '!'},');
              }
              mapBuffer.writelnTab(
                map((i) {
                  var value = returnValue(i.field);

                  final isValueFromExtClass =
                      value?.endsWith('().value') ?? false;

                  if (value == unassigned) {
                    value = methodType.map(map: null, maybeMap: defaultValue);
                  } else if (!isValueFromExtClass) {
                    value = _checkValueAndPrepare(value, i.field);
                  }

                  return tabn(i.returnString(value), tab);
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
  _Item convert(FieldData e) => _Item(enumName, e);

  /// prepares the value for the generation
  ///
  /// if type is `String`, it will be wrapped in quotes
  String? prepValueForGen(String? value) {
    final formattedValue = value?.replaceAll(RegExp('\n'), r'\n');

    if (typeAsString.startsWith('String') && formattedValue != null) {
      final start = formattedValue.startsWith("'") ? '' : "'";
      final end = formattedValue.endsWith("'") ? '' : "'";
      return '$start$formattedValue$end';
    }
    return formattedValue;
  }
}
