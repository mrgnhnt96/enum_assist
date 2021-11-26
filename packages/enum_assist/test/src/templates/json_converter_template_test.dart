import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/templates.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'MyEnum';

  setUp(() {
    fields = const {
      FieldData.manual(
        enumName: enumName,
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
        canUseSerializedValue: true,
        useIntValueForSerialization: false,
      );

      const output = '''
/// {@template my_enum.json_converter_nullable}
/// Serializes [MyEnum?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv.nullable
/// final MyEnum? myEnum;
/// ```
/// {@endtemplate}
class _MyEnumNullableConv extends JsonConverter<MyEnum?, Object?> {
  /// {@macro my_enum.json_converter}
  const _MyEnumNullableConv();

  @override
  MyEnum? fromJson(Object? json) {
    switch (json) {
      case MyEnumConv._oneName:
        return MyEnum.one;
      default:

      return null;
    }
  }

  @override
  Object? toJson(MyEnum? object) => object?.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use int value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: true,
        canUseSerializedValue: true,
        useIntValueForSerialization: true,
      );

      const output = '''
/// {@template my_enum.json_converter_nullable}
/// Serializes [MyEnum?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv.nullable
/// final MyEnum? myEnum;
/// ```
/// {@endtemplate}
class _MyEnumNullableConv extends JsonConverter<MyEnum?, Object?> {
  /// {@macro my_enum.json_converter}
  const _MyEnumNullableConv();

  @override
  MyEnum? fromJson(Object? json) {
    switch (json) {
      case MyEnumConv._oneName:
        return MyEnum.one;
      default:

      return null;
    }
  }

  @override
  Object? toJson(MyEnum? object) => object?.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use map instead of serialized method', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: true,
        canUseSerializedValue: false,
        useIntValueForSerialization: false,
      );

      const output = '''
/// {@template my_enum.json_converter_nullable}
/// Serializes [MyEnum?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv.nullable
/// final MyEnum? myEnum;
/// ```
/// {@endtemplate}
class _MyEnumNullableConv extends JsonConverter<MyEnum?, Object?> {
  /// {@macro my_enum.json_converter}
  const _MyEnumNullableConv();

  @override
  MyEnum? fromJson(Object? json) {
    switch (json) {
      case MyEnumConv._oneName:
        return MyEnum.one;
      default:

      return null;
    }
  }

  @override
  Object? toJson(MyEnum? object) => object?.map(
    one: MyEnumConv._oneName,
);
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
        canUseSerializedValue: true,
        useIntValueForSerialization: false,
      );

      const output = r'''
/// {@template my_enum.json_converter}
/// Serializes [MyEnum] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv()
/// final MyEnum myEnum;
/// ```
/// {@endtemplate}
class MyEnumConv extends JsonConverter<MyEnum, Object> {
  /// {@macro my_enum.json_converter}
  const MyEnumConv({this.defaultValue});

  /// the value to be used when no match is found
  final MyEnum? defaultValue;

  /// {@macro my_enum.json_converter_nullable}
  static const nullable = _MyEnumNullableConv();

  static const _oneName = 'one_number';

  @override
  MyEnum fromJson(Object json) {
    switch (json) {
      case _oneName:
        return MyEnum.one;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(MyEnum object) => object.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use int value', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: false,
        canUseSerializedValue: true,
        useIntValueForSerialization: true,
      );

      const output = r'''
/// {@template my_enum.json_converter}
/// Serializes [MyEnum] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv()
/// final MyEnum myEnum;
/// ```
/// {@endtemplate}
class MyEnumConv extends JsonConverter<MyEnum, Object> {
  /// {@macro my_enum.json_converter}
  const MyEnumConv({this.defaultValue});

  /// the value to be used when no match is found
  final MyEnum? defaultValue;

  /// {@macro my_enum.json_converter_nullable}
  static const nullable = _MyEnumNullableConv();

  static const _oneName = 1;

  @override
  MyEnum fromJson(Object json) {
    switch (json) {
      case _oneName:
        return MyEnum.one;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(MyEnum object) => object.serialized;
}
''';

      expect(template.toString(), output);
    });

    test('should use map instead of serialized method', () async {
      final template = JsonConverterTemplate(
        enumName,
        fields,
        isNullable: false,
        canUseSerializedValue: false,
        useIntValueForSerialization: false,
      );

      const output = r'''
/// {@template my_enum.json_converter}
/// Serializes [MyEnum] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MyEnumConv()
/// final MyEnum myEnum;
/// ```
/// {@endtemplate}
class MyEnumConv extends JsonConverter<MyEnum, Object> {
  /// {@macro my_enum.json_converter}
  const MyEnumConv({this.defaultValue});

  /// the value to be used when no match is found
  final MyEnum? defaultValue;

  /// {@macro my_enum.json_converter_nullable}
  static const nullable = _MyEnumNullableConv();

  static const _oneName = 'one_number';

  @override
  MyEnum fromJson(Object json) {
    switch (json) {
      case _oneName:
        return MyEnum.one;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  Object toJson(MyEnum object) => object.map(
    one: _oneName,
);
}
''';

      expect(template.toString(), output);
    });
  });
}
