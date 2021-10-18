/// {@template enum_assist.missing_value_exception}
/// The exception thrown when a value is missing
/// {@endtemplate}
class MissingValueException<T> implements Exception {
  /// {@macro enum_assist.missing_value_exception}
  const MissingValueException(this.key) : assert(key != null);

  /// the key/field of the missing value
  final T key;

  @override
  String toString() {
    if (key is String) return key as String;

    return 'Missing value for: $key';
  }
}

/// {@template enum_assist.invalid_value_exception}
/// The exception thrown when a value is null
/// and the return type is not nullable
/// {@endtemplate}
class NullValueException implements Exception {
  /// {@macro enum_assist.invalid_value_exception}
  const NullValueException(this.key, this.method);

  /// the key/field of the invalid value
  final String key;

  /// the method on which the error was thrown
  final String method;

  @override
  String toString() {
    return 'Null value for non-nullable field: $key for $method';
  }
}

/// {@template enum_assist.missing_extension_value_exception}
/// Thrown when an enum is annotated with an `AdditionalExtension`
/// and the value is missing
///
/// __only thrown if return type is not nullable__
/// {@endtemplate}
class MissingExtensionValueException implements Exception {
  /// {@macro enum_assist.missing_extension_value_exception}
  const MissingExtensionValueException(this.key, this.extension);

  /// the key/field of the invalid value
  final String key;

  /// the extension that was was expecting a value
  final String extension;

  @override
  String toString() {
    return '$key is missing a value annotation for $extension';
  }
}

/// {@template enum_assist.bad_string_format_exception}
/// Thrown when an enum is annotated with an `AdditionalExtension`
/// and the value is missing
///
/// __only thrown if return type is not nullable__
/// {@endtemplate}
class BadStringFormatException implements Exception {
  /// {@macro enum_assist.bad_string_format_exception}
  const BadStringFormatException(this.key, this.value);

  /// the key/field of the invalid value
  final String key;

  /// the value the was expected to be formatted
  final String value;

  @override
  String toString() {
    return '$key is not a valid string format: "$value"';
  }
}
