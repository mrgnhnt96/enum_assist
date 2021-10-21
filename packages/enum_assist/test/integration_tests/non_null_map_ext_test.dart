import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/non_null_map_ext.dart';
import '../integration/util/util.dart';
import '../util/nullable_values.dart';

void main() {
  const fileName = 'non_null_map_ext';
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
            dog: [20],
            cat: [100, 200, 300],
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
            dog: {'': 20},
            cat: {'a': 100, 'b': 200, 'c': 300},
            mouse: {'a': 400, 'b': 500, 'c': 600},
          );
        }

        for (final value in Animal.values) {
          expect(value.mapInt, getValue(value));
        }
      });
    });

    test('should return non nullable type', () {
      final value = Animal.values.first;

      isNotNullable(value.mapInt);
    });
  });

  group('$Familia', () {
    group('#translation', () {
      test('should return value from key annotation', () {
        Translation getValue(Familia value) {
          return value.map(
            madre: const Translation('mom'),
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
            madre: const [Apodo('la jefa'), Apodo('some cool name')],
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

  group('$Superhero', () {
    group('#boolExt', () {
      test('should return value from key annotation', () {
        bool getValue(Superhero value) {
          return value.map(
            superman: true,
          );
        }

        for (final value in Superhero.values) {
          expect(value.boolExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.boolExt);
      });
    });

    group('#intExt', () {
      test('should return value from key annotation', () {
        int getValue(Superhero value) {
          return value.map(
            superman: 1,
          );
        }

        for (final value in Superhero.values) {
          expect(value.intExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.intExt);
      });
    });

    group('#doubleExt', () {
      test('should return value from key annotation', () {
        double getValue(Superhero value) {
          return value.map(
            superman: .5,
          );
        }

        for (final value in Superhero.values) {
          expect(value.doubleExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.doubleExt);
      });
    });

    group('#stringExt', () {
      test('should return value from key annotation', () {
        String getValue(Superhero value) {
          return value.map(
            superman: 'value',
          );
        }

        for (final value in Superhero.values) {
          expect(value.stringExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.stringExt);
      });
    });

    group('#enumExt', () {
      test('should return value from key annotation', () {
        Animal getValue(Superhero value) {
          return value.map(
            superman: Animal.cat,
          );
        }

        for (final value in Superhero.values) {
          expect(value.enumExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.enumExt);
      });
    });

    group('#listExt', () {
      test('should return value from key annotation', () {
        List<int> getValue(Superhero value) {
          return value.map(
            superman: [1, 2, 3],
          );
        }

        for (final value in Superhero.values) {
          expect(value.listExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.listExt);
      });
    });

    group('#mapExt', () {
      test('should return value from key annotation', () {
        Map<String, int> getValue(Superhero value) {
          return value.map(
            superman: {'a': 1, 'b': 2, 'c': 3},
          );
        }

        for (final value in Superhero.values) {
          expect(value.mapExt, getValue(value));
        }
      });

      test('should return non nullable type', () {
        final value = Superhero.values.first;

        isNotNullable(value.mapExt);
      });
    });
  });
}
