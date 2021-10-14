// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file:

part of 'enums.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum FieldFormat
extension FieldFormatX on FieldFormat {
  /// Map of all values of the enum
  T map<T>({
    required T kebab,
    required T snake,
    required T pascal,
    required T camel,
    required T none,
  }) {
    switch (this) {
      case FieldFormat.kebab:
        return kebab;
      case FieldFormat.snake:
        return snake;
      case FieldFormat.pascal:
        return pascal;
      case FieldFormat.camel:
        return camel;
      case FieldFormat.none:
        return none;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T>({
    required T orElse,
    T? kebab,
    T? snake,
    T? pascal,
    T? camel,
    T? none,
  }) {
    switch (this) {
      case FieldFormat.kebab:
        if (kebab == null) return orElse;
        return kebab;
      case FieldFormat.snake:
        if (snake == null) return orElse;
        return snake;
      case FieldFormat.pascal:
        if (pascal == null) return orElse;
        return pascal;
      case FieldFormat.camel:
        if (camel == null) return orElse;
        return camel;
      case FieldFormat.none:
        if (none == null) return orElse;
        return none;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      kebab: 'Kebab',
      snake: 'Snake',
      pascal: 'Pascal',
      camel: 'Camel',
      none: 'None',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
      kebab: null,
      snake: null,
      pascal: null,
      camel: null,
      none: null,
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      kebab: FieldFormatConv._kebabName,
      snake: FieldFormatConv._snakeName,
      pascal: FieldFormatConv._pascalName,
      camel: FieldFormatConv._camelName,
      none: FieldFormatConv._noneName,
    );
  }
}

/// {@template field_format.json_converter}
/// Serializes [FieldFormat] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @FieldFormatConv()
/// final FieldFormat myEnum;
/// ```
/// {@endtemplate}
class FieldFormatConv extends JsonConverter<FieldFormat, String> {
  /// {@macro field_format.json_converter}
  const FieldFormatConv();

  static const _kebabName = 'kebab';
  static const _snakeName = 'snake';
  static const _pascalName = 'pascal';
  static const _camelName = 'camel';
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
      case _camelName:
        return FieldFormat.camel;
      case _noneName:
        return FieldFormat.none;
      default:
        throw Exception('Unknown field format: $json');
    }
  }

  @override
  String toJson(FieldFormat object) => object.serialized;
}

/// Extensions for the enum MethodType
extension MethodTypeX on MethodType {
  /// Map of all values of the enum
  T map<T>({
    required T map,
    required T maybeMap,
  }) {
    switch (this) {
      case MethodType.map:
        return map;
      case MethodType.maybeMap:
        return maybeMap;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T>({
    required T orElse,
    T? map,
    T? maybeMap,
  }) {
    switch (this) {
      case MethodType.map:
        if (map == null) return orElse;
        return map;
      case MethodType.maybeMap:
        if (maybeMap == null) return orElse;
        return maybeMap;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      map: 'Map',
      maybeMap: 'Maybe Map',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
      map: null,
      maybeMap: null,
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      map: MethodTypeConv._mapName,
      maybeMap: MethodTypeConv._maybeMapName,
    );
  }
}

/// {@template method_type.json_converter}
/// Serializes [MethodType] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MethodTypeConv()
/// final MethodType myEnum;
/// ```
/// {@endtemplate}
class MethodTypeConv extends JsonConverter<MethodType, String> {
  /// {@macro method_type.json_converter}
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
        throw Exception('Unknown field format: $json');
    }
  }

  @override
  String toJson(MethodType object) => object.serialized;
}
