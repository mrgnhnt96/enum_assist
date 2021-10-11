import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

/// Serializes [FieldFormat]
class FieldFormatConv extends JsonConverter<FieldFormat, String> {
  static const _kebabName = 'kebab';
  static const _snakeName = 'snake';
  static const _pascalName = 'pascal';
  static const _noneName = 'none';
  @override
  FieldFormat fromJson(String json) {
    switch (json) {
      case _kebabName:
        return FieldFormat.kebab;
      case _snakeName:
        return FieldFormat.snake;
      case _pascalName:
        return FieldFormat.pascal;
      case _noneName:
        return FieldFormat.none;
      default:
        throw Exception('Unknown field format: $json');
    }
  }

  @override
  String toJson(FieldFormat object) => object.map(
        kebab: _kebabName,
        snake: _snakeName,
        pascal: _pascalName,
        none: _noneName,
      );
}
