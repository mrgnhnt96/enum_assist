// GENERATED CODE - DO NOT MODIFY BY HAND

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
}

class NumbersConv extends JsonConverter<Numbers, String> {
  const NumbersConv();

  static const _onetyOneName = 'onety_one';
  static const _twothyTwoName = 'twothy_two';
  static const _threelyThreeName = 'threely_three';

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
