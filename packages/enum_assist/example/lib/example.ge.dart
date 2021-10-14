// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file:

part of 'example.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum Numbers
extension NumbersX on Numbers {
  /// Map of all values of the enum
  T map<T>({
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
  T maybeMap<T>({
    required T orElse,
    T? onetyOne,
    T? twothyTwo,
    T? threelyThree,
  }) {
    switch (this) {
      case Numbers.onetyOne:
        if (onetyOne == null) return orElse;
        return onetyOne;
      case Numbers.twothyTwo:
        if (twothyTwo == null) return orElse;
        return twothyTwo;
      case Numbers.threelyThree:
        if (threelyThree == null) return orElse;
        return threelyThree;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      onetyOne: 'onetyOne',
      twothyTwo: 'twothyTwo',
      threelyThree: 'threeThree',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
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
  const NumbersConv();

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
        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(Numbers object) => object.serialized;
}
