import 'package:enum_assist/src/configs/extension_value_config.dart';
import 'package:enum_assist/src/configs/key_config.dart';
import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late KeyConfig keyConfig;

  setUp(() {
    keyConfig = const KeyConfig(
      description: null,
      extensionValues: [],
      name: null,
      serializedValue: null,
      useDocCommentAsDescription: false,
    );
  });

  group('#privateName', () {
    test('returns the field name in a private format', () {
      const fieldName = 'Robin';
      final field = EnumField.manual(fieldName: fieldName);

      expect(field.privateName, '_${fieldName}Name');
    });
  });

  group('#wholeName', () {
    test('returns in an enum.field format', () {
      const enumName = 'Batman';
      const fieldName = 'Robin';
      final field =
          EnumField.manual(fieldName: fieldName, belongsToEnum: enumName);

      expect(field.wholeName, '$enumName.$fieldName');
    });
  });

  group('#getSerializedName', () {
    test('should return serialized name when provided via configs', () {
      const serializedName = 'robin';
      final config = keyConfig.copyWith(
        serializedValue: serializedName,
      );

      final field = EnumField.manual(config: config);

      expect(field.getSerializedName, serializedName);
    });

    test('should return field name when config does not have serialized value',
        () {
      const fieldName = 'Robin';
      final config = keyConfig.copyWith(
        serializedValue: null, // ignore: avoid_redundant_argument_values
      );

      final field = EnumField.manual(fieldName: fieldName, config: config);

      expect(field.getSerializedName, fieldName);
    });

    test('should format field name to case type', () {
      const fieldName = 'myFieldName';
      String caseString(SerializedFormat format) {
        return format.map(
          camel: 'myFieldName',
          constant: 'MY_FIELD_NAME',
          dot: 'my.field.name',
          kebab: 'my-field-name',
          no: 'my field name',
          none: 'myFieldName',
          pascal: 'MyFieldName',
          path: 'my/field/name',
          sentence: 'My field name',
          snake: 'my_field_name',
          swap: 'MYfIELDnAME',
          capital: 'My Field Name',
          header: 'My-Field-Name',
        );
      }

      for (final format in SerializedFormat.values) {
        final field = EnumField.manual(
          fieldName: fieldName,
          serializedFormat: format,
        );

        expect(field.getSerializedName, caseString(format));
      }
    });
  });

  group('#getDescription', () {
    test('should return description when not null', () {
      const description = 'My description';
      final config = keyConfig.copyWith(
        description: description,
      );

      final field = EnumField.manual(config: config);

      expect(field.getDescription, description);
    });

    test('should return doc comment when enabled and description is null', () {
      const docComment = 'My doc comment';
      final config = keyConfig.copyWith(
        description: null, // ignore: avoid_redundant_argument_values
        useDocCommentAsDescription: true,
      );

      final field = EnumField.manual(
        config: config,
        docComment: docComment,
      );

      expect(field.getDescription, docComment);
    });

    test(
        'should return null when doc comment is disabled and description is null', // ignore: line_length
        () {
      final config = keyConfig.copyWith(
        description: null, // ignore: avoid_redundant_argument_values
        useDocCommentAsDescription: false,
      );

      final field = EnumField.manual(config: config);

      expect(field.getDescription, null);
    });

    test('should remove all "///" and spaces', () {
      const description = 'My doc comment';
      const docComment = '/// $description';

      final config = keyConfig.copyWith(
        description: null, // ignore: avoid_redundant_argument_values
        useDocCommentAsDescription: true,
      );

      final field = EnumField.manual(
        config: config,
        docComment: docComment,
      );

      expect(field.getDescription, description);
    });

    test('should remove "///" keep line breaks', () {
      const description = 'My\n\ndescription';
      final docComment = description.split('\n').join('\n/// ');

      final config = keyConfig.copyWith(
        description: null, // ignore: avoid_redundant_argument_values
        useDocCommentAsDescription: true,
      );

      final field = EnumField.manual(
        config: config,
        docComment: docComment,
      );

      expect(field.getDescription, description);
    });

    test('should keep all line breaks', () {
      const docComment = 'My\n\ndescription';

      final config = keyConfig.copyWith(
        description: null, // ignore: avoid_redundant_argument_values
        useDocCommentAsDescription: true,
      );

      final field = EnumField.manual(
        config: config,
        docComment: docComment,
      );

      expect(field.getDescription, docComment);
    });
  });

  group('#getName', () {
    test('should return name when provided', () {
      const fieldName = 'myFieldName';
      const newFieldName = 'My Field Name';

      final config = keyConfig.copyWith(
        name: newFieldName,
      );
      final field = EnumField.manual(fieldName: fieldName, config: config);

      expect(field.getName, newFieldName);
    });

    test('should return the field name when name is not provided', () {
      const fieldName = 'myFieldName';

      final field = EnumField.manual(fieldName: fieldName);

      expect(
        field.getName.replaceAll(' ', '').toLowerCase(),
        fieldName.toLowerCase(),
      );
    });

    test('should return the field name formatted to capital case', () {
      const fieldName = 'myFieldName';
      const capitalCase = 'My Field Name';

      final field = EnumField.manual(fieldName: fieldName);

      expect(field.getName, capitalCase);
    });
  });

  group('#getExtensionValue', () {
    test('should return null when extensionValues is empty', () {
      final config = keyConfig.copyWith(extensionValues: []);
      final field = EnumField.manual(config: config);

      expect(field.getExtensionValue(''), null);
    });

    test('should return matching extension value to value class name', () {
      const valueClassName = 'MyValueClass';
      final extensionValueConfig = ExtensionValueConfigMock(valueClassName);

      final config = keyConfig.copyWith(
        extensionValues: [extensionValueConfig],
      );

      final field = EnumField.manual(config: config);

      expect(field.getExtensionValue(valueClassName), extensionValueConfig);
    });

    test('should return null if no matching extension value class exists', () {
      const valueClassName = 'MyValueClass';
      final extensionValueConfig = ExtensionValueConfigMock(valueClassName);

      final config = keyConfig.copyWith(
        extensionValues: [extensionValueConfig],
      );

      final field = EnumField.manual(config: config);

      expect(field.getExtensionValue('OtherValueClass'), isNull);
    });
  });

  group('#toString', () {
    test('should return the field name', () {
      const fieldName = 'myFieldName';
      final field = EnumField.manual(fieldName: fieldName);

      expect(field.toString(), fieldName);
    });
  });
}

class ExtensionValueConfigMock extends Mock implements ExtensionValueConfig {
  ExtensionValueConfigMock(this.valueClassName);

  @override
  final String valueClassName;
}
