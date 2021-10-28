import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/use_int_value_for_serialization.dart';
import '../integration/util/util.dart';

void main() {
  const fileName = 'use_int_value_for_serialization';
  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('$Animal', () {
    test('should return value from key annotation', () {
      Object getValue(Animal value) {
        return value.map(
          dog: 0,
          cat: 1,
          mouse: 2,
        );
      }

      for (final value in Animal.values) {
        expect(value.serialized, getValue(value));
      }
    });
  });

  group('$Letters', () {
    test('should return value from key annotation', () {
      Object getValue(Letters value) {
        return value.map(
          handWritten: 0,
          email: 1,
          hate: 2,
        );
      }

      for (final value in Letters.values) {
        expect(value.serialized, getValue(value));
      }
    });
  });

  group('$Familia', () {
    test('should return value from key annotation', () {
      Object getValue(Familia value) {
        return value.map(
          madre: 101,
          padre: 102,
          hijo: 103,
        );
      }

      for (final value in Familia.values) {
        expect(value.serialized, getValue(value));
      }
    });
  });

  group('$Candy', () {
    test('should return value from key annotation', () {
      Object getValue(Candy value) {
        return value.map(
          skittles: 0,
          butterfinger: 200,
          reeses: 201,
        );
      }

      for (final value in Candy.values) {
        expect(value.serialized, getValue(value));
      }
    });
  });
}
