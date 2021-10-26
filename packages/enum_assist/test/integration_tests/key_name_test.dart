import 'package:test/test.dart';

import '../integration/key_annotation.dart';

void main() {
  group('#name', () {
    test('should return value from key annotation', () {
      String getName(Animal value) {
        return value.map(
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
    test('should return value from key annotation', () {
      String getName(Animal value) {
        return value.map(
          dog: 'Doggy',
          cat: 'Kitty',
          mouse: 'Mousy',
        );
      }

      for (final value in Animal.values) {
        expect(value.readable, getName(value));
      }
    });
  });

  group('#description', () {
    test('should return value from key annotation', () {
      String getName(Animal value) {
        return value.map(
          dog: 'Doggy description',
          cat: 'Kitty description',
          mouse: 'Mousy description',
        );
      }

      for (final value in Animal.values) {
        expect(value.description, getName(value));
      }
    });
  });

  group('#serializedValue', () {
    test('should return value from key annotation', () {
      String getName(Animal value) {
        return value.map(
          dog: 'doggy',
          cat: 'kitty',
          mouse: 'mousy',
        );
      }

      for (final value in Animal.values) {
        expect(value.serialized, getName(value));
      }
    });
  });
}
