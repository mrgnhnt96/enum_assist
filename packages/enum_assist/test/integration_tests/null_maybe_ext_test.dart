import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/null_maybe_ext.dart';
import '../integration/util/util.dart';
import '../util/nullable_values.dart';

void main() {
  const fileName = 'null_maybe_ext';
  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('$Animal', () {
    group('#list', () {
      test('should return value from key annotation', () {
        List<int>? getValue(Animal value) {
          return value.map(
            dog: [20],
            cat: null,
            mouse: [10],
          );
        }

        for (final value in Animal.values) {
          expect(value.list, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Animal.values.first;

      isNullable(value.list);
    });

    group('#mapExt', () {
      test('should return value from key annotation', () {
        Map<String, int>? getValue(Animal value) {
          return value.map(
            dog: {'': 20},
            cat: null,
            mouse: {'': 10},
          );
        }

        for (final value in Animal.values) {
          expect(value.mapExt, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Animal.values.first;

      isNullable(value.mapExt);
    });
  });

  group('$Familia', () {
    group('#translation', () {
      test('should return value from key annotation', () {
        Translation? getValue(Familia value) {
          return value.map(
            madre: const Translation('mom'),
            padre: null,
            hijo: const Translation('default'),
          );
        }

        for (final value in Familia.values) {
          expect(value.translation, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Familia.values.first;

      isNullable(value.translation);
    });

    group('#apodo', () {
      test('should return value from key annotation', () {
        List<Apodo>? getValue(Familia value) {
          return value.map(
            madre: const [Apodo('la jefa'), Apodo('some cool name')],
            padre: null,
            hijo: const [Apodo('default')],
          );
        }

        for (final value in Familia.values) {
          expect(value.apodo, getValue(value));
        }
      });
    });

    test('should return nullable type', () {
      final value = Familia.values.first;

      isNullable(value.apodo);
    });
  });
}
