import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/serialized_value.dart';
import '../integration/util/util.dart';

void main() {
  const fileName = 'serialized_value';
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
          dog: 'dog',
          cat: 'cat',
          mouse: 'mouse',
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
          handWritten: 'handWritten',
          email: 'email',
          hate: 'hate',
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
          madre: 1,
          padre: 2,
          hijo: 3,
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
          skittles: 'Familia.madre',
          butterfinger: 'butterfinger',
          reeses: 1,
          kitkat: 2,
          snickers: 3,
        );
      }

      for (final value in Candy.values) {
        expect(value.serialized, getValue(value));
      }
    });
  });
}
