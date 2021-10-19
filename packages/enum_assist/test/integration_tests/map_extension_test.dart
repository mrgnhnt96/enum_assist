import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/map_extension.dart';
import '../integration/util/double_extension.dart';
import '../integration/util/util.dart';
import '../util/nullable_values.dart';

void main() {
  const fileName = 'map_extension';
  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('$Animal', () {
    group('#numExtension', () {
      test('should return value from key annotation', () {
        int getValue(Animal value) {
          return value.map(
            dog: 100,
            cat: 200,
            mouse: 300,
          );
        }

        for (final value in Animal.values) {
          expect(value.numExtension, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Animal.values.first;

      isNotNullable(value.numExtension);
    });
  });

  group('$Letters', () {
    group('#nullNumExtension', () {
      test('should return value from key annotation', () {
        int? getValue(Letters value) {
          return value.map(
            handWritten: null,
            email: 200,
            hate: null,
          );
        }

        for (final value in Letters.values) {
          expect(value.nullNumExtension, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Letters.values.first;

      isNullable(value.nullNumExtension);
    });
  });

  group('$BodyParts', () {
    group('#veryFar', () {
      test('should return value from key annotation', () {
        double? getValue(BodyParts value) {
          return value.map(
            head: 1.01,
            body: 2.01,
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

      isNotNullable(value.veryFar);
    });
  });

  group('$Family', () {
    group('#durationExtension', () {
      test('should return value from key annotation', () {
        Duration getValue(Family value) {
          return value.map(
            mom: const Duration(days: 1),
            dad: const Duration(days: 2),
            kid: const Duration(days: 3),
          );
        }

        for (final value in Family.values) {
          expect(value.durationExtension, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Family.values.first;

      isNotNullable(value.durationExtension);
    });
  });

  group('$Familia', () {
    group('#myClassExtension', () {
      test('should return value from key annotation', () {
        MyClass getValue(Familia value) {
          return value.map(
            madre: const MyClass('mama'),
            padre: const MyClass('papa'),
            hijo: const MyClass('mijo'),
          );
        }

        for (final value in Familia.values) {
          expect(value.myClassExtension, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Familia.values.first;

      isNotNullable(value.myClassExtension);
    });
  });
}
