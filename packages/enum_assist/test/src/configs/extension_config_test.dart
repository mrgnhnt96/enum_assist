import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:test/test.dart';

void main() {
  group('@methodName', () {
    test('should return formatted to camelCase', () {
      expect(
        ExtensionConfig.manual(methodName: 'get user').methodName,
        'getUser',
      );
      expect(
        ExtensionConfig.manual(methodName: 'getUser').methodName,
        'getUser',
      );
      expect(
        ExtensionConfig.manual(methodName: 'GetUser').methodName,
        'getUser',
      );
    });
  });

  group('#getDocComment', () {
    test('when null, return "/// @nodoc"', () {
      final config = ExtensionConfig.manual(
          docComment: null); // ignore: avoid_redundant_argument_values

      expect(config.getDocComment(), '/// @nodoc');
    });

    test('should add "///" to the start of line', () {
      final config = ExtensionConfig.manual(
        docComment: 'Superman has always been cooler',
      );

      expect(config.getDocComment(), '/// Superman has always been cooler');
    });

    test('should add "///" to the start of each new line', () {
      final config = ExtensionConfig.manual(
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
}
