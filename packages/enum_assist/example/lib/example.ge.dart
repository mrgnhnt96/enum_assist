// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file:

part of 'example.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

extension NumbersX on Numbers {
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

  String get name {
    return map(
      onetyOne: 'Onety One',
      twothyTwo: 'Twothy Two',
      threelyThree: 'threeThree',
    );
  }

  String? get description {
    return maybeMap(
      orElse: null,
      onetyOne: 'this is a fake 11',
      twothyTwo: 'this is a fake 22',
      threelyThree: 'this is a fake 33 and probably something else',
    );
  }

  String get myCoolMethod {
    return map(
      onetyOne: '11',
      twothyTwo: '22',
      threelyThree: '33',
    );
  }
}

class NumbersConv extends JsonConverter<Numbers, String> {
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
        throw Exception('Unknown field format: $json');
    }
  }

  @override
  String toJson(Numbers object) => object.map(
        onetyOne: _onetyOneName,
        twothyTwo: _twothyTwoName,
        threelyThree: _threelyThreeName,
      );
}
