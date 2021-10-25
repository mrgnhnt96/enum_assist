import 'package:test/test.dart';

import '../integration/create_json_conv.dart';
import '../integration/util/util.dart';

void main() {
  const fileName = 'create_json_conv';

  test('has no issue', () async {
    final main = await getLibraryElement(fileName);
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('$Animal', () {
    test('should return name of enum value', () {
      const comments = {
        Animal.dog: 'dog',
        Animal.cat: 'cat',
        Animal.mouse: 'mouse',
      };

      for (final value in Animal.values) {
        expect(value.serialized, comments[value]);
      }
    });
  });

  group('$Letters', () {
    test('should return #serializedValue value', () {
      const comments = {
        Letters.handWritten: 'handWrittenValue',
        Letters.email: 'emailValue',
        Letters.hate: 'hateValue',
      };

      for (final value in Letters.values) {
        expect(value.serialized, comments[value]);
      }
    });
  });

  group('$Vehicle', () {
    test('should return name of enum value', () {
      const comments = {
        Vehicle.car: 'car',
        Vehicle.plane: 'plane',
        Vehicle.train: 'train',
      };

      for (final value in Vehicle.values) {
        expect(value.serialized, comments[value]);
      }
    });
  });
}
