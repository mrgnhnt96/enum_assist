import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

/// Extension used for [FieldFormat]
extension FieldFormatX on FieldFormat {
  /// Returns the [FieldFormat] as a [FieldRename]
  FieldRename toRename() => map(
        kebab: FieldRename.kebab,
        snake: FieldRename.snake,
        pascal: FieldRename.pascal,
        none: FieldRename.none,
      );
}
