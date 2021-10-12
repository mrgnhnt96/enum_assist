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
