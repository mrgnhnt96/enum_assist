part of '../create_name.dart';

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

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      dog: AnimalConv._dogName,
      cat: AnimalConv._catName,
      mouse: AnimalConv._mouseName,
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
  Object toJson(Animal object) => object.serialized;
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
  Object? toJson(Animal? object) => object?.serialized;
}
