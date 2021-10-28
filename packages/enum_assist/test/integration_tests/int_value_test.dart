import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/int_value.dart';
import '../integration/util/util.dart';

void main() {
  const fileName = 'int_value';
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
      int getValue(Animal value) {
        return value.map(
          dog: 0,
          cat: 1,
          mouse: 2,
        );
      }

      for (final value in Animal.values) {
        expect(value.toInt, getValue(value));
      }
    });
  });

  group('$Letters', () {
    test('should return value from key annotation', () {
      int getValue(Letters value) {
        return value.map(
          handWritten: 0,
          email: 1,
          hate: 2,
        );
      }

      for (final value in Letters.values) {
        expect(value.toInt, getValue(value));
      }
    });
  });

  group('$Familia', () {
    test('should return value from key annotation', () {
      int getValue(Familia value) {
        return value.map(
          madre: 3,
          padre: 4,
          hijo: 5,
        );
      }

      for (final value in Familia.values) {
        expect(value.toInt, getValue(value));
      }
    });
  });

  group('$Candy', () {
    test('should return value from key annotation', () {
      int getValue(Candy value) {
        return value.map(
          skittles: 6,
          butterfinger: 7,
          reeses: 8,
        );
      }

      for (final value in Candy.values) {
        expect(value.toInt, getValue(value));
      }
    });
  });

  group('$Soda', () {
    test('should return value from key annotation', () {
      int getValue(Soda value) {
        return value.map(
          coke: 0,
          pepsi: 200,
          sprite: 201,
          fanta: 4,
        );
      }

      for (final value in Soda.values) {
        expect(value.toInt, getValue(value));
      }
    });
  });
}
