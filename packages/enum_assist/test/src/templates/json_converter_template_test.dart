import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/templates.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(
        index: 0,
        fieldName: 'one',
        intValue: 1,
        serializedValue: 'one_number',
      ),
    };
  });

  group('nullable conv', () {
    test('should use serialized value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: true,
        useIntValueForSerialization: false,
      );

      const output = '''
/// {@template enum_name.json_converter_nullable}
/// Serializes [enumName?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @enumNameConv.nullable
/// final enumName? myEnum;
/// ```
/// {@endtemplate}
class _enumNameNullableConv extends JsonConverter<enumName?, Object?> {
  /// {@macro enum_name.json_converter}
  const _enumNameNullableConv();

  @override
  enumName? fromJson(Object? json) {
    switch (json) {
      case enumNameConv._oneName:
        return enumName.one;
      default:

      return null;
    }
  }

  @override
Object? toJson(enumName? object) => object?.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use int value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: true,
        useIntValueForSerialization: true,
      );

      const output = '''
/// {@template enum_name.json_converter_nullable}
/// Serializes [enumName?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @enumNameConv.nullable
/// final enumName? myEnum;
/// ```
/// {@endtemplate}
class _enumNameNullableConv extends JsonConverter<enumName?, Object?> {
  /// {@macro enum_name.json_converter}
  const _enumNameNullableConv();

  @override
  enumName? fromJson(Object? json) {
    switch (json) {
      case enumNameConv._oneName:
        return enumName.one;
      default:

      return null;
    }
  }

  @override
Object? toJson(enumName? object) => object?.serialized;
}
''';

      expect(template.toString(), output);
    });
  });

  group('non-nullable conv', () {
    test('should use serialized value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: false,
        useIntValueForSerialization: false,
      );

      const output = r'''
/// {@template enum_name.json_converter}
/// Serializes [enumName] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @enumNameConv()
/// final enumName myEnum;
/// ```
/// {@endtemplate}
class enumNameConv extends JsonConverter<enumName, Object> {
  /// {@macro enum_name.json_converter}
  const enumNameConv({this.defaultValue});

  /// the value to be used when no match is found
  final enumName? defaultValue;

  /// {@macro enum_name.json_converter_nullable}
  static const nullable = _enumNameNullableConv();

  static const _oneName = 'one_number';

  @override
  enumName fromJson(Object json) {
    switch (json) {
      case _oneName:
        return enumName.one;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
Object toJson(enumName object) => object.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use int value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: false,
        useIntValueForSerialization: true,
      );

      const output = r'''
/// {@template enum_name.json_converter}
/// Serializes [enumName] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @enumNameConv()
/// final enumName myEnum;
/// ```
/// {@endtemplate}
class enumNameConv extends JsonConverter<enumName, Object> {
  /// {@macro enum_name.json_converter}
  const enumNameConv({this.defaultValue});

  /// the value to be used when no match is found
  final enumName? defaultValue;

  /// {@macro enum_name.json_converter_nullable}
  static const nullable = _enumNameNullableConv();

  static const _oneName = 1;

  @override
  enumName fromJson(Object json) {
    switch (json) {
      case _oneName:
        return enumName.one;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
Object toJson(enumName object) => object.serialized;
}
''';

      expect(template.toString(), output);
    });
  });
}
