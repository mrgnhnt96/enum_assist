import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template enum_assist_annotation.field_format_conv}
/// Serializes [FieldFormat]
/// {@endtemplate}
class FieldFormatConv extends JsonConverter<FieldFormat, String> {
  /// {@macro enum_assist_annotation.field_format_conv}
  const FieldFormatConv();

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

/// {@macro enum_assist_annotation.field_format_conv}
class MethodTypeConv extends JsonConverter<MethodType, String> {
  /// {@macro enum_assist_annotation.field_format_conv}
  const MethodTypeConv();

  static const _mapName = 'map';
  static const _maybeMapName = 'maybeMap';
  @override
  MethodType fromJson(String json) {
    switch (json) {
      case _mapName:
        return MethodType.map;
      case _maybeMapName:
        return MethodType.maybeMap;
      default:
        throw Exception('Unknown method type: $json');
    }
  }

  @override
  String toJson(MethodType object) {
    switch (object) {
      case MethodType.map:
        return _mapName;
      case MethodType.maybeMap:
        return _maybeMapName;
      default:
        throw Exception('Unknown method type: $object');
    }
  }
}
