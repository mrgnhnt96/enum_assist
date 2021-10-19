import 'package:test/expect.dart';

void isNullable<T>(T value) =>
    expect(() => _canBeNotBeNull(value), throwsA(isA<NullableException>()));
void isNotNullable<T>(T value) =>
    expect(() => _canBeNull(value), throwsA(isA<NonNullableException>()));

/// throws [NullableException]
void _canBeNotBeNull<T>(T value) {
  try {
    value = null as T;
  } catch (_) {
    // passes
    return;
  }

  throw NullableException(value);
}

/// throws [NonNullableException]
void _canBeNull<T>(T value) {
  try {
    null as T;
    // passes
    return;
  } catch (_) {
    throw NonNullableException(value);
  }
}

class NullableException<T> implements Exception {
  const NullableException(this.value);

  final T value;

  @override
  String toString() {
    return '$T (from $value) is a nullable type';
  }
}

class NonNullableException<T> implements Exception {
  const NonNullableException(this.value);

  final T value;

  @override
  String toString() {
    return '$T (from $value) is not a nullable type';
  }
}
