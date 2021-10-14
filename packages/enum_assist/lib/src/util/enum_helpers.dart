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

  final enumValue = values.singleWhere((v) => obj.getField(getName(v)) != null);

  return enumValue;
}
