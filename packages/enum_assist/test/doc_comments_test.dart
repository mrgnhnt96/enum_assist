import 'package:test/test.dart';

import 'integration/doc_comments.dart';

void main() {
  test('should return all doc comments', () {
    const comments = {
      Animal.dog: 'dog doc comment',
      Animal.cat: 'cat doc comment',
      Animal.mouse: 'mouse doc comment',
    };

    for (final value in Animal.values) {
      expect(value.description, comments[value]);
    }
  });

  test('should return no doc comments', () {
    const comments = {
      Letters.handWritten: isNull,
      Letters.email: isNull,
      Letters.hate: isNull,
    };

    for (final value in Letters.values) {
      expect(value.description, comments[value]);
    }
  });

  test('should return except for use doc comment as description set to false',
      () {
    const comments = {
      Vehicle.car: 'car doc comment',
      Vehicle.plane: isNull,
      Vehicle.train: 'train doc comment',
    };

    for (final value in Vehicle.values) {
      expect(value.description, comments[value]);
    }
  });

  test('should return except for overriden descriptions', () {
    const comments = {
      BodyParts.head: 'head doc comment',
      BodyParts.arm: 'My arms look tiny',
      BodyParts.leg: 'leg doc comment',
    };

    for (final value in BodyParts.values) {
      expect(value.description, comments[value]);
    }
  });
}
