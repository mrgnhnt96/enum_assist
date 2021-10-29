import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

import '../integration/annotation_only.dart';
import '../util/util.dart';

void main() {
  const fileName = 'annotation_only';

  test('has no issue', () async {
    final main = await getLibraryElement(fileName);
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('#map', () {
    test('returns signature of all args and return as same type', () {
      const enumValue = Animal.dog;

      expect('${enumValue.map}',
          'Closure: <Y0>({Y0 dog, Y0 cat, Y0 mouse}) => Y0');
    });

    test('returns based on enumValue', () {
      String getString(Animal enumValue) {
        return enumValue.map(
          dog: 'dog',
          cat: 'cat',
          mouse: 'mouse',
        );
      }

      for (final value in Animal.values) {
        expect(getString(value), value.toString().split('.').last);
      }
    });
  });

  group('#maybeMap', () {
    test(
        'returns signature of all optional args, orElse, '
        'and return as same type ', () {
      const enumValue = Animal.dog;

      expect('${enumValue.maybeMap}',
          'Closure: <Y0>({Y0 orElse, Y0? dog, Y0? cat, Y0? mouse}) => Y0');
    });

    test('returns based on enumValue', () {
      String getString(Animal enumValue) {
        return enumValue.maybeMap(
          dog: 'dog',
          cat: 'cat',
          mouse: 'mouse',
          orElse: 'orElse',
        );
      }

      for (final value in Animal.values) {
        expect(getString(value), value.toString().split('.').last);
      }
    });

    test('returns orElse when not nullable and values are not assigned', () {
      String getString(Animal enumValue) {
        return enumValue.maybeMap(
          orElse: 'orElse',
        );
      }

      for (final value in Animal.values) {
        expect(getString(value), 'orElse');
      }
    });

    test('returns null when nullable and only orElse is assigned', () {
      String? getString(Animal enumValue) {
        return enumValue.maybeMap(
          orElse: 'orElse',
        );
      }

      for (final value in Animal.values) {
        expect(getString(value), isNull);
      }
    });
  });

  group('#name', () {
    test('returns the field name in title case', () {
      String getName(Animal animal) {
        return animal.map(
          dog: 'dog',
          cat: 'cat',
          mouse: 'mouse',
        );
      }

      for (final value in Animal.values) {
        expect(value.name, getName(value));
      }
    });
  });

  group('#readable', () {
    test('returns the field name in title case', () {
      String getName(Animal animal) {
        return animal.map(
          dog: 'Dog',
          cat: 'Cat',
          mouse: 'Mouse',
        );
      }

      for (final value in Animal.values) {
        expect(value.readable, getName(value));
      }
    });
  });

  group('description', () {
    test('returns null', () {
      for (final value in Animal.values) {
        expect(value.description, null);
      }
    });
  });

  group('#serialized', () {
    test('returns the field name', () {
      for (final value in Animal.values) {
        expect(value.serialized, value.toString().split('.').last);
      }
    });
  });

  group('$AnimalConv', () {
    late JsonConverter conv;
    const json = {
      'dog': Animal.dog,
      'cat': Animal.cat,
      'mouse': Animal.mouse,
    };

    setUp(() {
      conv = const AnimalConv();
    });

    test('is a json converter type of animal and object', () {
      expect(conv, isA<JsonConverter<Animal, Object>>());
    });

    group('#fromJson', () {
      test('returns animal enum from json', () {
        for (final entry in json.entries) {
          final key = entry.key;
          final value = entry.value;

          expect(conv.fromJson(key), value);
        }
      });

      test('throws when no value matches', () {
        expect(() => conv.fromJson('not-a-value'), throwsA(isA<Exception>()));
      });

      test('returns default value if no match', () {
        const cat = Animal.cat;
        const convWithDefault = AnimalConv(defaultValue: cat);

        expect(convWithDefault.fromJson('not-a-value'), cat);
      });
    });

    group('#toJson', () {
      test('returns to json from animal enum', () {
        for (final entry in json.entries) {
          final key = entry.key;
          final value = entry.value;

          expect(conv.toJson(value), key);
        }
      });
    });
  });

  group('AnimalNullableConv', () {
    late JsonConverter conv;
    const json = {
      'dog': Animal.dog,
      'cat': Animal.cat,
      'mouse': Animal.mouse,
    };

    setUp(() {
      conv = AnimalConv.nullable;
    });

    test('is a json converter nullable type of animal and object', () {
      expect(conv, isA<JsonConverter<Animal?, Object?>>());
    });

    group('#fromJson', () {
      test('returns animal enum from json', () {
        for (final entry in json.entries) {
          final key = entry.key;
          final value = entry.value;

          expect(conv.fromJson(key), value);
        }
      });

      test('returns null when no value matches', () {
        expect(conv.fromJson('not-a-value'), isNull);
      });
    });

    group('#toJson', () {
      test('returns to json from animal enum', () {
        for (final entry in json.entries) {
          final key = entry.key;
          final value = entry.value;

          expect(conv.toJson(value), key);
        }
      });
    });
  });
}
