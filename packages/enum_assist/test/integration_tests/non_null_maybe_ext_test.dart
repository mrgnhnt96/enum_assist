import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/non_null_maybe_ext.dart';
import '../integration/util/util.dart';
import '../util/nullable_values.dart';

void main() {
  const fileName = 'non_null_maybe_ext';
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
        List<int> getValue(Animal value) {
          return value.map(
            dog: [10],
            cat: [20],
            mouse: [400, 500, 600],
          );
        }

        for (final value in Animal.values) {
          expect(value.list, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Animal.values.first;

      isNotNullable(value.list);
    });

    group('#mapExt', () {
      test('should return value from key annotation', () {
        Map<String, int> getValue(Animal value) {
          return value.map(
            dog: {'': 10},
            cat: {'': 20},
            mouse: {'a': 400, 'b': 500, 'c': 600},
          );
        }

        for (final value in Animal.values) {
          expect(value.mapExt, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Animal.values.first;

      isNotNullable(value.mapExt);
    });
  });

  group('$Familia', () {
    group('#translation', () {
      test('should return value from key annotation', () {
        Translation getValue(Familia value) {
          return value.map(
            madre: const Translation('default'),
            padre: const Translation('dad'),
            hijo: const Translation('son'),
          );
        }

        for (final value in Familia.values) {
          expect(value.translation, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Familia.values.first;

      isNotNullable(value.translation);
    });

    group('#apodo', () {
      test('should return value from key annotation', () {
        List<Apodo> getValue(Familia value) {
          return value.map(
            madre: const [],
            padre: const [Apodo('peluche'), Apodo('some cool name')],
            hijo: const [Apodo('moco'), Apodo('[{some cool{, } name}]')],
          );
        }

        for (final value in Familia.values) {
          expect(value.apodo, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Familia.values.first;

      isNotNullable(value.apodo);
    });
  });
}
