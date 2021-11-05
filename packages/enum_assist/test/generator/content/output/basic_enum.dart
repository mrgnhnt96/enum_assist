part of '../basic_enum.dart';

/// Extensions for the enum Example
extension ExampleX on Example {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T one,
    required T two,
    required T three,
  }) {
    switch (this) {
      case Example.one:
        return one;
      case Example.two:
        return two;
      case Example.three:
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
      case Example.one:
        if (one == null && !isNullable) return orElse;
        return one as T;
      case Example.two:
        if (two == null && !isNullable) return orElse;
        return two as T;
      case Example.three:
        if (three == null && !isNullable) return orElse;
        return three as T;
    }
  }

  /// Returns the name of the enum field
  String get name {
    return map<String>(
      one: 'one',
      two: 'two',
      three: 'three',
    );
  }

  /// The enum value converted to an integer
  int get toInt {
    return map<int>(
      one: 0,
      two: 1,
      three: 2,
    );
  }

  /// Returns the name of the enum field
  /// In a human readable format
  String get readable {
    return map<String>(
      one: 'One',
      two: 'Two',
      three: 'Three',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map<String?>(
      one: null,
      two: null,
      three: null,
    );
  }

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      one: ExampleConv._oneName,
      two: ExampleConv._twoName,
      three: ExampleConv._threeName,
    );
  }
}

/// {@template example.json_converter}
/// Serializes [Example] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @ExampleConv()
/// final Example myEnum;
/// ```
/// {@endtemplate}
class ExampleConv extends JsonConverter<Example, Object> {
  /// {@macro example.json_converter}
  const ExampleConv({this.defaultValue});

  /// the value to be used when no match is found
  final Example? defaultValue;

  /// {@macro example.json_converter_nullable}
  static const nullable = _ExampleNullableConv();

  static const _oneName = 'one';
  static const _twoName = 'two';
  static const _threeName = 'three';

  @override
  Example fromJson(Object json) {
    switch (json) {
      case _oneName:
        return Example.one;
      case _twoName:
        return Example.two;
      case _threeName:
        return Example.three;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(Example object) => object.serialized;
}

/// {@template example.json_converter_nullable}
/// Serializes [Example?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @ExampleConv.nullable
/// final Example? myEnum;
/// ```
/// {@endtemplate}
class _ExampleNullableConv extends JsonConverter<Example?, Object?> {
  /// {@macro example.json_converter}
  const _ExampleNullableConv();

  @override
  Example? fromJson(Object? json) {
    switch (json) {
      case ExampleConv._oneName:
        return Example.one;
      case ExampleConv._twoName:
        return Example.two;
      case ExampleConv._threeName:
        return Example.three;
      default:
        return null;
    }
  }

  @override
  Object? toJson(Example? object) => object?.serialized;
}
