import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'enums.ge.dart';

/// {@template enum_assist_annotation.field_format}
/// Formats the field name when serializing.
/// {@endtemplate}
@EnumAssist(useDocCommentAsDescription: false)
enum SerializedFormat {
  /// {@template enum_assist_annotation.field_format.kebab}
  /// formats value to kebab-case
  /// (e.g. `fieldName` becomes `field-name`).
  /// {@endtemplate}
  kebab,

  /// {@template enum_assist_annotation.field_format.snake}
  /// formats value to snake_case
  /// (e.g. `fieldName` becomes `field_name`).
  /// {@endtemplate}
  snake,

  /// {@template enum_assist_annotation.field_format.pascal}
  /// formats value to PascalCase
  /// (e.g. `fieldName` becomes `FieldName`).
  /// {@endtemplate}
  pascal,

  /// {@template enum_assist_annotation.field_format.camel_case}
  /// formats value to camelCase
  /// (e.g. `field_name` becomes `fieldName`).
  /// {@endtemplate}
  camel,

  /// {@template enum_assist_annotation.field_format.none}
  /// does not format the value
  /// (e.g. `fieldName` remains `fieldName`).
  /// {@endtemplate}
  none,
}

/// {@template enum_assist.method_type}
/// Determines how to set up the generated method.
/// {@endtemplate}
@EnumAssist(useDocCommentAsDescription: false)
enum MethodType {
  /// The generated method will be `map(...)`.
  ///
  /// requires annotation [EnumKey] on all enum values
  map,

  /// The generated method will be `maybeMap(...)`.
  ///
  /// __does not__ require annotation [EnumKey] all enum values
  maybeMap,
}
