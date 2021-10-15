import 'package:analyzer/dart/constant/value.dart';

/// gets the value of an Enum from a Dart Object
T? getEnumFromDartObject<T>(
  DartObject? obj,
  List<T> values,
) {
  if (obj == null) {
    return null;
  }

  String getName(T format) => '$format'.split('.').last;

  T? enumValue;
  try {
    enumValue = values.firstWhere((v) => obj.getField(getName(v!)) != null);
  } catch (_) {
    // there was no enum value found
    // continue
  }

  return enumValue;
}
