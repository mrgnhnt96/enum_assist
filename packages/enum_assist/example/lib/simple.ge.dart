// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names,prefer_const_declarations,unused_local_variable,prefer_int_literals,lines_longer_than_80_chars,prefer_const_constructors

part of 'simple.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum SimpleEnum
extension SimpleEnumX on SimpleEnum {
  /// Map of all values of the enum
  T map<T extends Object?>({
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
  T maybeMap<T extends Object?>({
    required T orElse,
    T? one,
    T? two,
    T? three,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case SimpleEnum.one:
        if (one == null && !isNullable) return orElse;
        return one as T;
      case SimpleEnum.two:
        if (two == null && !isNullable) return orElse;
        return two as T;
      case SimpleEnum.three:
        if (three == null && !isNullable) return orElse;
        return three as T;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      one: 'name',
      two: 'Two',
      three: 'Three',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map(
      one: '''
description''',
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

  /// @nodoc
  Duration get myCoolMethod {
    return map(
      one: Duration(days: 1),
      two: Duration(days: 1),
      three: Duration(days: 1),
    );
  }

  /// @nodoc
  Duration? get myCoolMethod2 {
    return maybeMap(
      // returns default value
      //? if theres a provided value, it does nothing.
      orElse: MyValue2(value: Duration(days: 1)).defaultValue,
      one: Duration(days: 1),
      two: Duration(days: 1),
      three: MyValue2(value: Duration(days: 1)).defaultValue,
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
  const SimpleEnumConv({this.defaultValue});

  /// the value to be used when no match is found
  final SimpleEnum? defaultValue;

  /// {@macro simple_enum.json_converter_nullable}
  static const nullable = _SimpleEnumNullableConv();

  static const _oneName = 'value';
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
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(SimpleEnum object) => object.serialized;
}

/// {@template simple_enum.json_converter_nullable}
/// Serializes [SimpleEnum?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @SimpleEnumConv.nullable
/// final SimpleEnum? myEnum;
/// ```
/// {@endtemplate}
class _SimpleEnumNullableConv extends JsonConverter<SimpleEnum?, String?> {
  /// {@macro simple_enum.json_converter}
  const _SimpleEnumNullableConv();

  @override
  SimpleEnum? fromJson(String? json) {
    switch (json) {
      case SimpleEnumConv._oneName:
        return SimpleEnum.one;
      case SimpleEnumConv._twoName:
        return SimpleEnum.two;
      case SimpleEnumConv._threeName:
        return SimpleEnum.three;
      default:
        return null;
    }
  }

  @override
  String? toJson(SimpleEnum? object) => object?.serialized;
}
