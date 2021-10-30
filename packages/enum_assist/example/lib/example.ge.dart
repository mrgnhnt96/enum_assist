// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names,prefer_const_declarations,unused_local_variable,prefer_int_literals,lines_longer_than_80_chars,prefer_const_constructors

part of 'example.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum Numbers
extension NumbersX on Numbers {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T eleven,
    required T twentyTwo,
    required T thirtyThree,
  }) {
    switch (this) {
      case Numbers.eleven:
        return eleven;
      case Numbers.twentyTwo:
        return twentyTwo;
      case Numbers.thirtyThree:
        return thirtyThree;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? eleven,
    T? twentyTwo,
    T? thirtyThree,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case Numbers.eleven:
        if (eleven == null && !isNullable) return orElse;
        return eleven as T;
      case Numbers.twentyTwo:
        if (twentyTwo == null && !isNullable) return orElse;
        return twentyTwo as T;
      case Numbers.thirtyThree:
        if (thirtyThree == null && !isNullable) return orElse;
        return thirtyThree as T;
    }
  }

  /// Returns the name of the enum field
  String get name {
    return map<String>(
      eleven: 'eleven',
      twentyTwo: 'twentyTwo',
      thirtyThree: 'thirtyThree',
    );
  }

  /// The enum value converted to an integer
  int get toInt {
    return map<int>(
      eleven: 0,
      twentyTwo: 1,
      thirtyThree: 2,
    );
  }

  /// Returns the name of the enum field
  /// In a human readable format
  String get readable {
    return map<String>(
      eleven: 'Eleven',
      twentyTwo: 'Twenty Two',
      thirtyThree: 'Thirty Three',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map<String?>(
      eleven: '''
11 is also a girl from Stranger Things''',
      twentyTwo: null,
      thirtyThree: null,
    );
  }

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      eleven: NumbersConv._elevenName,
      twentyTwo: NumbersConv._twentyTwoName,
      thirtyThree: NumbersConv._thirtyThreeName,
    );
  }

  /// converts value to a map
  Map<String, int> get toMap {
    return map<Map<String, int>>(
      eleven: {'eleven': 11},
      twentyTwo: {'twenty-two': 22},
      thirtyThree: {'thirty-three': 33},
    );
  }

  /// whether the value is prime
  bool get isPrime {
    return maybeMap<bool>(
      // returns default value
      //? if theres an argument provided, it does nothing.
      orElse: IsPrime(true).defaultValue!,
      eleven: true,
      twentyTwo: null,
      thirtyThree: null,
    );
  }
}

/// {@template numbers.json_converter}
/// Serializes [Numbers] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @NumbersConv()
/// final Numbers myEnum;
/// ```
/// {@endtemplate}
class NumbersConv extends JsonConverter<Numbers, Object> {
  /// {@macro numbers.json_converter}
  const NumbersConv({this.defaultValue});

  /// the value to be used when no match is found
  final Numbers? defaultValue;

  /// {@macro numbers.json_converter_nullable}
  static const nullable = _NumbersNullableConv();

  static const _elevenName = 'eleven';
  static const _twentyTwoName = 'twentyTwo';
  static const _thirtyThreeName = 'thirtyThree';

  @override
  Numbers fromJson(Object json) {
    switch (json) {
      case _elevenName:
        return Numbers.eleven;
      case _twentyTwoName:
        return Numbers.twentyTwo;
      case _thirtyThreeName:
        return Numbers.thirtyThree;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(Numbers object) => object.serialized;
}

/// {@template numbers.json_converter_nullable}
/// Serializes [Numbers?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @NumbersConv.nullable
/// final Numbers? myEnum;
/// ```
/// {@endtemplate}
class _NumbersNullableConv extends JsonConverter<Numbers?, Object?> {
  /// {@macro numbers.json_converter}
  const _NumbersNullableConv();

  @override
  Numbers? fromJson(Object? json) {
    switch (json) {
      case NumbersConv._elevenName:
        return Numbers.eleven;
      case NumbersConv._twentyTwoName:
        return Numbers.twentyTwo;
      case NumbersConv._thirtyThreeName:
        return Numbers.thirtyThree;
      default:
        return null;
    }
  }

  @override
  Object? toJson(Numbers? object) => object?.serialized;
}
