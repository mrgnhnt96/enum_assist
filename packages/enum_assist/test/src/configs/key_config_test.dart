import 'package:enum_assist/src/configs/key_config.dart';
import 'package:test/test.dart';

void main() {
  group('#defaults', () {
    final defaults = KeyConfig.defaults;

    test('name should return null', () {
      expect(defaults.name, isNull);
    });

    test('description should return null', () {
      expect(defaults.description, isNull);
    });

    test('serializedValue should return null', () {
      expect(defaults.serializedValue, isNull);
    });

    test('useDocCommentAsDescription should return true', () {
      expect(defaults.useDocCommentAsDescription, isTrue);
    });

    test('extensionValues should return empty list', () {
      expect(defaults.extensionValues, isEmpty);
    });
  });
}
