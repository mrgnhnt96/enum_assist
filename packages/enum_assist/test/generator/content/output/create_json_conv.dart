part of '../create_json_conv.dart';

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

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      dog: 'dog',
      cat: 'cat',
      mouse: 'mouse',
    );
  }
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

  /// Returns the serialized value of the enum field.
  Object get serialized {
    return map<Object>(
      handWritten: 'handWrittenValue',
      email: 'emailValue',
      hate: 'hateValue',
    );
  }
}
