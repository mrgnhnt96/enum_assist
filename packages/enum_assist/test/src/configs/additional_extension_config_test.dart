import 'package:enum_assist/src/configs/additional_extension_config.dart';
import 'package:test/test.dart';

void main() {
  group('#getDocComment', () {
    test('when null, return "/// @nodoc"', () {
      final config = AdditionalExtensionConfig.manual();

      expect(config.getDocComment(), '/// @nodoc');
    });

    test('should add "///" to the start of line', () {
      final config = AdditionalExtensionConfig.manual(
        docComment: 'Superman has always been cooler',
      );

      expect(config.getDocComment(), '/// Superman has always been cooler');
    });

    test('should add "///" to the start of each new line', () {
      final config = AdditionalExtensionConfig.manual(
        docComment: '''
Superman has always been cooler

No brah, its Batman foreva''',
      );

      final lines = config.getDocComment().split('\n');

      for (final line in lines) {
        expect(line, startsWith('///'));
      }
    });
  });

  group('#isValueTypeNullable', () {
    test('should return false when not nullable', () {
      final config = AdditionalExtensionConfig.manual(valueType: 'int');

      expect(config.isValueTypeNullable, isFalse);
    });

    test('should return true when nullable', () {
      final config = AdditionalExtensionConfig.manual(
        valueType: 'int?',
      );

      expect(config.isValueTypeNullable, isTrue);
    });
  });
}
