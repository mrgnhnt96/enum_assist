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
    required T onetyOne,
    required T twothyTwo,
    required T threelyThree,
  }) {
    switch (this) {
      case Numbers.onetyOne:
        return onetyOne;
      case Numbers.twothyTwo:
        return twothyTwo;
      case Numbers.threelyThree:
        return threelyThree;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? onetyOne,
    T? twothyTwo,
    T? threelyThree,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case Numbers.onetyOne:
        if (onetyOne == null && !isNullable) return orElse;
        return onetyOne as T;
      case Numbers.twothyTwo:
        if (twothyTwo == null && !isNullable) return orElse;
        return twothyTwo as T;
      case Numbers.threelyThree:
        if (threelyThree == null && !isNullable) return orElse;
        return threelyThree as T;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      onetyOne: 'Onety One',
      twothyTwo: 'Twothy Two',
      threelyThree: 'threeThree',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map(
      onetyOne: '''
this is a fake 11''',
      twothyTwo: '''
this is a fake 22''',
      threelyThree: '''
this is a fake 33



and probably something else''',
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      onetyOne: NumbersConv._onetyOneName,
      twothyTwo: NumbersConv._twothyTwoName,
      threelyThree: NumbersConv._threelyThreeName,
    );
  }

  /// @nodoc
  String get myCoolMethod {
    return map(
      onetyOne: '11',
      twothyTwo: '22',
      threelyThree: '33',
    );
  }

  /// @nodoc
  int? get nullableMethod {
    return map(
      onetyOne: 12,
      twothyTwo: null,
      threelyThree: null,
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
class NumbersConv extends JsonConverter<Numbers, String> {
  /// {@macro numbers.json_converter}
  const NumbersConv({this.defaultValue});

  /// the value to be used when no match is found
  final Numbers? defaultValue;

  /// {@macro numbers.json_converter_nullable}
  static const nullable = _NumbersNullableConv();

  static const _onetyOneName = 'onety_one';
  static const _twothyTwoName = 'twothy_two';
  static const _threelyThreeName = '1';

  @override
  Numbers fromJson(String json) {
    switch (json) {
      case _onetyOneName:
        return Numbers.onetyOne;
      case _twothyTwoName:
        return Numbers.twothyTwo;
      case _threelyThreeName:
        return Numbers.threelyThree;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(Numbers object) => object.serialized;
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
class _NumbersNullableConv extends JsonConverter<Numbers?, String?> {
  /// {@macro numbers.json_converter}
  const _NumbersNullableConv();

  @override
  Numbers? fromJson(String? json) {
    switch (json) {
      case NumbersConv._onetyOneName:
        return Numbers.onetyOne;
      case NumbersConv._twothyTwoName:
        return Numbers.twothyTwo;
      case NumbersConv._threelyThreeName:
        return Numbers.threelyThree;
      default:
        return null;
    }
  }

  @override
  String? toJson(Numbers? object) => object?.serialized;
}
