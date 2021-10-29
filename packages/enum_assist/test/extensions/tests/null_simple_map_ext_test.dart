import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../../src/util/nullable_values.dart';
import '../integration/null_simple_map_ext.dart';
import '../util/util.dart';

void main() {
  const fileName = 'null_simple_map_ext';
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
        int? getValue(Animal value) {
          return value.map(
            dog: null,
            cat: null,
            mouse: null,
          );
        }

        for (final value in Animal.values) {
          expect(value.smallNum, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Animal.values.first;

      isNullable(value.smallNum);
    });
  });

  group('$BodyParts', () {
    group('#veryFar', () {
      test('should return value from key annotation', () {
        double? getValue(BodyParts value) {
          return value.map(
            head: null,
            body: null,
            leg: 3.01,
          );
        }

        for (final value in BodyParts.values) {
          expect(value.veryFar, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = BodyParts.values.first;

      isNullable(value.veryFar);
    });
  });

  group('$Family', () {
    group('#duration', () {
      test('should return value from key annotation', () {
        Duration? getValue(Family value) {
          return value.map(
            mom: const Duration(days: 1),
            dad: const Duration(days: 2),
            kid: null,
          );
        }

        for (final value in Family.values) {
          expect(value.duration, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Family.values.first;

      isNullable(value.duration);
    });
  });
}
