/// Formats the field name when serializing.
enum FieldFormat {
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

  /// {@template enum_assist_annotation.field_format.none}
  /// does not format the value
  /// (e.g. `fieldName` remains `fieldName`).
  /// {@endtemplate}
  none,
}
