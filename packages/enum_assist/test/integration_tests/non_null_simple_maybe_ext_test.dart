import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/non_null_simple_maybe_ext.dart';
import '../integration/util/util.dart';
import '../src/util/nullable_values.dart';

void main() {
  const fileName = 'non_null_simple_maybe_ext';
  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('$Animal', () {
    group('#smallNum', () {
      test('should return value from key annotation', () {
        int getValue(Animal value) {
          return value.map(
            dog: 10,
            cat: 20,
            mouse: 300,
          );
        }

        for (final value in Animal.values) {
          expect(value.smallNum, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Animal.values.first;

      isNotNullable(value.smallNum);
    });
  });

  group('$BodyParts', () {
    group('#veryFar', () {
      test('should return value from key annotation', () {
        double getValue(BodyParts value) {
          return value.map(
            head: 12,
            body: 2.01,
            leg: 3.01,
          );
        }

        for (final value in BodyParts.values) {
          expect(value.veryFar, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = BodyParts.values.first;

      isNotNullable(value.veryFar);
    });
  });

  group('$Family', () {
    group('#duration', () {
      test('should return value from key annotation', () {
        Duration getValue(Family value) {
          return value.map(
            mom: const Duration(days: 1),
            dad: const Duration(days: 10),
            kid: const Duration(days: 3),
          );
        }

        for (final value in Family.values) {
          expect(value.duration, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Family.values.first;

      isNotNullable(value.duration);
    });
  });
}
