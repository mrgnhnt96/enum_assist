import 'package:analyzer/dart/constant/value.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  group('#getEnumFromDartObject', () {
    late DartObjectMock dartObject;

    setUp(() {
      dartObject = DartObjectMock();
      reset(dartObject);
    });

    test('should return null when no dart object is provided', () {
      expect(getEnumFromDartObject<String>(null, []), isNull);
    });

    test('should not return null when field exists in object', () {
      when(() => dartObject.getField(any())).thenReturn(DartObjectMock());

      final enumName = getEnumFromDartObject(dartObject, TestEnum.values);

      expect(enumName, isNotNull);
    });

    test('should return null when field does not exists in object', () {
      when(() => dartObject.getField(any())).thenReturn(null);

      final enumName = getEnumFromDartObject(dartObject, TestEnum.values);

      expect(enumName, isNull);
    });

    test('should return first occurrence of field', () {
      when(() => dartObject.getField(any())).thenReturn(DartObjectMock());

      final enumName = getEnumFromDartObject(dartObject, TestEnum.values);

      expect(enumName, TestEnum.values.first);
    });
  });
}

class DartObjectMock extends Mock implements DartObject {}

enum TestEnum {
  A,
  B,
  C,
}
