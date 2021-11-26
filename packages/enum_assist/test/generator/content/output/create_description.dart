part of '../create_description.dart';

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

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      handWritten: LettersConv._handWrittenName,
      email: LettersConv._emailName,
      hate: LettersConv._hateName,
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

  static const _handWrittenName = 'handWritten';
  static const _emailName = 'email';
  static const _hateName = 'hate';

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
  Object toJson(Letters object) => object.serialized;
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
  Object? toJson(Letters? object) => object?.serialized;
}

/// Extensions for the enum Vehicle
extension VehicleX on Vehicle {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T car,
    required T plane,
    required T train,
  }) {
    switch (this) {
      case Vehicle.car:
        return car;
      case Vehicle.plane:
        return plane;
      case Vehicle.train:
        return train;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? car,
    T? plane,
    T? train,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case Vehicle.car:
        if (car == null && !isNullable) return orElse;
        return car as T;
      case Vehicle.plane:
        if (plane == null && !isNullable) return orElse;
        return plane as T;
      case Vehicle.train:
        if (train == null && !isNullable) return orElse;
        return train as T;
    }
  }

  /// Returns the name of the enum field
  String get name {
    return map<String>(
      car: 'car',
      plane: 'plane',
      train: 'train',
    );
  }

  /// The enum value converted to an integer
  int get toInt {
    return map<int>(
      car: 0,
      plane: 1,
      train: 2,
    );
  }

  /// Returns the name of the enum field
  /// In a human readable format
  String get readable {
    return map<String>(
      car: 'Car',
      plane: 'Plane',
      train: 'Train',
    );
  }

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      car: VehicleConv._carName,
      plane: VehicleConv._planeName,
      train: VehicleConv._trainName,
    );
  }
}

/// {@template vehicle.json_converter}
/// Serializes [Vehicle] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @VehicleConv()
/// final Vehicle myEnum;
/// ```
/// {@endtemplate}
class VehicleConv extends JsonConverter<Vehicle, Object> {
  /// {@macro vehicle.json_converter}
  const VehicleConv({this.defaultValue});

  /// the value to be used when no match is found
  final Vehicle? defaultValue;

  /// {@macro vehicle.json_converter_nullable}
  static const nullable = _VehicleNullableConv();

  static const _carName = 'car';
  static const _planeName = 'plane';
  static const _trainName = 'train';

  @override
  Vehicle fromJson(Object json) {
    switch (json) {
      case _carName:
        return Vehicle.car;
      case _planeName:
        return Vehicle.plane;
      case _trainName:
        return Vehicle.train;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(Vehicle object) => object.serialized;
}

/// {@template vehicle.json_converter_nullable}
/// Serializes [Vehicle?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @VehicleConv.nullable
/// final Vehicle? myEnum;
/// ```
/// {@endtemplate}
class _VehicleNullableConv extends JsonConverter<Vehicle?, Object?> {
  /// {@macro vehicle.json_converter}
  const _VehicleNullableConv();

  @override
  Vehicle? fromJson(Object? json) {
    switch (json) {
      case VehicleConv._carName:
        return Vehicle.car;
      case VehicleConv._planeName:
        return Vehicle.plane;
      case VehicleConv._trainName:
        return Vehicle.train;
      default:
        return null;
    }
  }

  @override
  Object? toJson(Vehicle? object) => object?.serialized;
}
