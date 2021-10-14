// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file:

part of 'simple.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum SimpleEnum
extension SimpleEnumX on SimpleEnum {
  /// Map of all values of the enum
  T map<T>({
    required T one,
    required T two,
    required T three,
  }) {
    switch (this) {
      case SimpleEnum.one:
        return one;
      case SimpleEnum.two:
        return two;
      case SimpleEnum.three:
        return three;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T>({
    required T orElse,
    T? one,
    T? two,
    T? three,
  }) {
    switch (this) {
      case SimpleEnum.one:
        if (one == null) return orElse;
        return one;
      case SimpleEnum.two:
        if (two == null) return orElse;
        return two;
      case SimpleEnum.three:
        if (three == null) return orElse;
        return three;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      one: 'One',
      two: 'Two',
      three: 'Three',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
      one: null,
      two: null,
      three: null,
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      one: SimpleEnumConv._oneName,
      two: SimpleEnumConv._twoName,
      three: SimpleEnumConv._threeName,
    );
  }
}

/// {@template simple_enum.json_converter}
/// Serializes [SimpleEnum] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @SimpleEnumConv()
/// final SimpleEnum myEnum;
/// ```
/// {@endtemplate}
class SimpleEnumConv extends JsonConverter<SimpleEnum, String> {
  /// {@macro simple_enum.json_converter}
  const SimpleEnumConv();

  static const _oneName = 'one';
  static const _twoName = 'two';
  static const _threeName = 'three';

  @override
  SimpleEnum fromJson(String json) {
    switch (json) {
      case _oneName:
        return SimpleEnum.one;
      case _twoName:
        return SimpleEnum.two;
      case _threeName:
        return SimpleEnum.three;
      default:
        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(SimpleEnum object) => object.serialized;
}
