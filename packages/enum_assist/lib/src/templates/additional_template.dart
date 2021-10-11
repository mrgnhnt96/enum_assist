import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';
import 'package:meta/meta.dart';

class _Item extends FieldTemplate<EnumField> {
  const _Item(String enumName, EnumField field) : super(enumName, field);

  String returnString<T>(T value) => '$field: ${_formatType(value)},';
}

String _formatType<T>(T s) {
  switch (s.runtimeType) {
    case String:
      return "'$s'";
    default:
      return '$s';
  }
}

/// {@template enum_assist.additional_template}
/// Helper class to create [AdditionalTemplate]s
/// {@endtemplate}
abstract class AdditionalTemplate<T> extends TemplateCoreDetailed<_Item>
    implements AdditionalMethod<T> {
  /// {@macro enum_assist.additional_template}
  AdditionalTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required this.defaultValue,
    required this.methodName,
    required this.returnValue,
    required this.requireAllFields,
  })  : accessMethod = requireAllFields ? 'map' : 'maybeMap',
        super(enumName, fields);

  /// The name of the method to call
  @override
  final String methodName;

  /// the value to be returned by the enum value
  final T Function(EnumField) returnValue;

  /// the access method that will be used
  ///
  /// Options:
  /// - `map`
  /// - `maybeMap`
  final String accessMethod;

  /// Handles to return the default value if no field is found
  final bool requireAllFields;

  @override
  final T defaultValue;

  @protected
  @nonVirtual
  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer.writeobj(
      '$T get $methodName',
      body: (nameBuffer, tab) {
        nameBuffer.writeobj(
          'return $accessMethod',
          tab: tab,
          open: '(',
          close: ');',
          body: (mapBuffer, mapTab) {
            if (!requireAllFields) {
              mapBuffer.writeln('orElse: ${_formatType(defaultValue)},');
            }
            mapBuffer.writelnTab(
              map((i) => tabn(i.returnString(getValue(i.field)), tab)),
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

  @override
  T getValue(EnumField field) => returnValue(field);
}

/// {@template enum_assist.additional_map_template}
/// helper class to create [AdditionalMapTemplate]s
///
/// Uses the [map] method to access the enum value
/// {@endtemplate}
class AdditionalMapTemplate<T extends Object> extends AdditionalTemplate<T> {
  /// {@macro enum_assist.additional_map_template}
  AdditionalMapTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required String methodName,
    required T Function(EnumField) getValue,
    required T defaultValue,
  }) : super(
          enumName,
          fields,
          methodName: methodName,
          defaultValue: defaultValue,
          returnValue: getValue,
          requireAllFields: true,
        );
}

/// {@template enum_assist.additional_map_template}
/// helper class to create [AdditionalMapTemplate]s
///
/// Uses the [map] method to access the enum value
/// {@endtemplate}
class AdditionalMaybeMapTemplate<T extends Object?>
    extends AdditionalTemplate<T> {
  /// {@macro enum_assist.additional_map_template}
  AdditionalMaybeMapTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required String methodName,
    required T Function(EnumField) getValue,
    required T defaultValue,
  }) : super(
          enumName,
          fields,
          methodName: methodName,
          defaultValue: defaultValue,
          returnValue: getValue,
          requireAllFields: false,
        );
}

/// helper class to create [AdditionalTemplate]s
abstract class AdditionalMethod<T> {
  /// the name of the method to call
  String get methodName;

  /// the default value to be returned by the enum value
  T get defaultValue;

  /// the value to be returned by the enum value
  T getValue(EnumField field);
}
