import 'package:enum_assist/src/src.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:test/test.dart';

void main() {
  late Map<String, dynamic> settings;

  setUp(() {
    settings = <String, dynamic>{};
  });

  Settings getSettings() => Settings.resolve(settings);

  group('#create_json_conv', () {
    const key = 'create_json_conv';

    test('should return true', () {
      settings[key] = true;
      expect(getSettings().config.createJsonConv, isTrue);
    });

    test('should return false', () {
      settings[key] = false;
      expect(getSettings().config.createJsonConv, isFalse);
    });
  });

  group('#serialized_format', () {
    const key = 'serialized_format';

    test('should return camel', () {
      settings[key] = 'camel';

      expect(getSettings().config.serializedFormat, SerializedFormat.camel);
    });

    test('should return capital', () {
      settings[key] = 'capital';

      expect(getSettings().config.serializedFormat, SerializedFormat.capital);
    });

    test('should return constant', () {
      settings[key] = 'constant';

      expect(getSettings().config.serializedFormat, SerializedFormat.constant);
    });

    test('should return dot', () {
      settings[key] = 'dot';

      expect(getSettings().config.serializedFormat, SerializedFormat.dot);
    });

    test('should return header', () {
      settings[key] = 'header';

      expect(getSettings().config.serializedFormat, SerializedFormat.header);
    });

    test('should return kebab', () {
      settings[key] = 'kebab';

      expect(getSettings().config.serializedFormat, SerializedFormat.kebab);
    });

    test('should return no', () {
      settings[key] = 'no';

      expect(getSettings().config.serializedFormat, SerializedFormat.no);
    });

    test('should return none', () {
      settings[key] = 'none';

      expect(getSettings().config.serializedFormat, SerializedFormat.none);
    });

    test('should return pascal', () {
      settings[key] = 'pascal';

      expect(getSettings().config.serializedFormat, SerializedFormat.pascal);
    });

    test('should return path', () {
      settings[key] = 'path';

      expect(getSettings().config.serializedFormat, SerializedFormat.path);
    });

    test('should return sentence', () {
      settings[key] = 'sentence';

      expect(getSettings().config.serializedFormat, SerializedFormat.sentence);
    });

    test('should return snake', () {
      settings[key] = 'snake';

      expect(getSettings().config.serializedFormat, SerializedFormat.snake);
    });

    test('should return swap', () {
      settings[key] = 'swap';

      expect(getSettings().config.serializedFormat, SerializedFormat.swap);
    });
  });

  group('use_doc_comment_as_description', () {
    const key = 'use_doc_comment_as_description';

    test('should return true', () {
      settings[key] = true;
      expect(getSettings().config.useDocCommentAsDescription, isTrue);
    });

    test('should return false', () {
      settings[key] = false;
      expect(getSettings().config.useDocCommentAsDescription, isFalse);
    });
  });

  group('use_int_value_for_serialization', () {
    const key = 'use_int_value_for_serialization';

    test('should return true', () {
      settings[key] = true;
      expect(getSettings().config.useIntValueForSerialization, isTrue);
    });

    test('should return false', () {
      settings[key] = false;
      expect(getSettings().config.useIntValueForSerialization, isFalse);
    });
  });
}
