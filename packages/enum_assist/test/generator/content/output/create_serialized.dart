part of '../create_serialized.dart';

/// Extensions for the enum Animal
extension AnimalX on Animal {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T dog,
    required T cat,
    required T mouse,
  }) {
    switch (this) {
      case Animal.dog:
        return dog;
      case Animal.cat:
        return cat;
      case Animal.mouse:
        return mouse;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? dog,
    T? cat,
    T? mouse,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case Animal.dog:
        if (dog == null && !isNullable) return orElse;
        return dog as T;
      case Animal.cat:
        if (cat == null && !isNullable) return orElse;
        return cat as T;
      case Animal.mouse:
        if (mouse == null && !isNullable) return orElse;
        return mouse as T;
    }
  }

  /// Returns the name of the enum field
  String get name {
    return map<String>(
      dog: 'dog',
      cat: 'cat',
      mouse: 'mouse',
    );
  }

  /// The enum value converted to an integer
  int get toInt {
    return map<int>(
      dog: 0,
      cat: 1,
      mouse: 2,
    );
  }

  /// Returns the name of the enum field
  /// In a human readable format
  String get readable {
    return map<String>(
      dog: 'Dog',
      cat: 'Cat',
      mouse: 'Mouse',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map<String?>(
      dog: null,
      cat: null,
      mouse: null,
    );
  }
}

/// {@template animal.json_converter}
/// Serializes [Animal] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @AnimalConv()
/// final Animal myEnum;
/// ```
/// {@endtemplate}
class AnimalConv extends JsonConverter<Animal, Object> {
  /// {@macro animal.json_converter}
  const AnimalConv({this.defaultValue});

  /// the value to be used when no match is found
  final Animal? defaultValue;

  /// {@macro animal.json_converter_nullable}
  static const nullable = _AnimalNullableConv();

  static const _dogName = 'dog';
  static const _catName = 'cat';
  static const _mouseName = 'mouse';

  @override
  Animal fromJson(Object json) {
    switch (json) {
      case _dogName:
        return Animal.dog;
      case _catName:
        return Animal.cat;
      case _mouseName:
        return Animal.mouse;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(Animal object) => object.map(
        dog: _dogName,
        cat: _catName,
        mouse: _mouseName,
      );
}

/// {@template animal.json_converter_nullable}
/// Serializes [Animal?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @AnimalConv.nullable
/// final Animal? myEnum;
/// ```
/// {@endtemplate}
class _AnimalNullableConv extends JsonConverter<Animal?, Object?> {
  /// {@macro animal.json_converter}
  const _AnimalNullableConv();

  @override
  Animal? fromJson(Object? json) {
    switch (json) {
      case AnimalConv._dogName:
        return Animal.dog;
      case AnimalConv._catName:
        return Animal.cat;
      case AnimalConv._mouseName:
        return Animal.mouse;
      default:
        return null;
    }
  }

  @override
  Object? toJson(Animal? object) => object?.map(
        dog: AnimalConv._dogName,
        cat: AnimalConv._catName,
        mouse: AnimalConv._mouseName,
      );
}

/// Extensions for the enum Letters
extension LettersX on Letters {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T handWritten,
    required T email,
    required T hate,
  }) {
    switch (this) {
      case Letters.handWritten:
        return handWritten;
      case Letters.email:
        return email;
      case Letters.hate:
        return hate;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? handWritten,
    T? email,
    T? hate,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case Letters.handWritten:
        if (handWritten == null && !isNullable) return orElse;
        return handWritten as T;
      case Letters.email:
        if (email == null && !isNullable) return orElse;
        return email as T;
      case Letters.hate:
        if (hate == null && !isNullable) return orElse;
        return hate as T;
    }
  }

  /// Returns the name of the enum field
  String get name {
    return map<String>(
      handWritten: 'handWritten',
      email: 'email',
      hate: 'hate',
    );
  }

  /// The enum value converted to an integer
  int get toInt {
    return map<int>(
      handWritten: 0,
      email: 1,
      hate: 2,
    );
  }

  /// Returns the name of the enum field
  /// In a human readable format
  String get readable {
    return map<String>(
      handWritten: 'Hand Written',
      email: 'Email',
      hate: 'Hate',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map<String?>(
      handWritten: null,
      email: null,
      hate: null,
    );
  }
}

/// {@template letters.json_converter}
/// Serializes [Letters] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @LettersConv()
/// final Letters myEnum;
/// ```
/// {@endtemplate}
class LettersConv extends JsonConverter<Letters, Object> {
  /// {@macro letters.json_converter}
  const LettersConv({this.defaultValue});

  /// the value to be used when no match is found
  final Letters? defaultValue;

  /// {@macro letters.json_converter_nullable}
  static const nullable = _LettersNullableConv();

  static const _handWrittenName = 'handWrittenValue';
  static const _emailName = 'emailValue';
  static const _hateName = 'hateValue';

  @override
  Letters fromJson(Object json) {
    switch (json) {
      case _handWrittenName:
        return Letters.handWritten;
      case _emailName:
        return Letters.email;
      case _hateName:
        return Letters.hate;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(Letters object) => object.map(
        handWritten: _handWrittenName,
        email: _emailName,
        hate: _hateName,
      );
}

/// {@template letters.json_converter_nullable}
/// Serializes [Letters?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @LettersConv.nullable
/// final Letters? myEnum;
/// ```
/// {@endtemplate}
class _LettersNullableConv extends JsonConverter<Letters?, Object?> {
  /// {@macro letters.json_converter}
  const _LettersNullableConv();

  @override
  Letters? fromJson(Object? json) {
    switch (json) {
      case LettersConv._handWrittenName:
        return Letters.handWritten;
      case LettersConv._emailName:
        return Letters.email;
      case LettersConv._hateName:
        return Letters.hate;
      default:
        return null;
    }
  }

  @override
  Object? toJson(Letters? object) => object?.map(
        handWritten: LettersConv._handWrittenName,
        email: LettersConv._emailName,
        hate: LettersConv._hateName,
      );
}
