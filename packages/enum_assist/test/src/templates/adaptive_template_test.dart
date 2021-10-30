import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/adaptive_template.dart';
import 'package:enum_assist/src/templates/extension_template.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(
        index: 0,
        fieldName: 'one',
      ),
      FieldData.manual(
        index: 1,
        fieldName: 'two',
      ),
      FieldData.manual(
        index: 2,
        fieldName: 'three',
      ),
    };
  });

  String? getValue(FieldData data) {
    switch (data.index) {
      case 0:
        return '${data.index}';
      case 1:
        return null;
      case 2:
        return unassigned;
      default:
        throw Exception('No value found for ${data.index}');
    }
  }

  group('map', () {
    test('should return non-nullable method', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: getValue,
        defaultValue: null,
        typeAsString: '$String',
        methodType: MethodType.map,
        docComment: '/// doc comment',
        allowNulls: false,
      );

      const output = '''
/// doc comment
String get method {
  return map<String>(
    one: '0',
    two: null,
    three: null,
  );
}
''';

      expect(template.toString(), output);
    });

    test('should return nullable method', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: getValue,
        defaultValue: null,
        typeAsString: '$String',
        methodType: MethodType.map,
        docComment: '/// doc comment',
        allowNulls: true,
      );

      const output = '''
/// doc comment
String? get method {
  return map<String?>(
    one: '0',
    two: null,
    three: null,
  );
}
''';

      expect(template.toString(), output);
    });
  });

  group('maybeMap', () {
    test('should return value', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: getValue,
        defaultValue: "'hello'",
        typeAsString: '$String',
        methodType: MethodType.maybeMap,
        docComment: '/// doc comment',
        allowNulls: true,
      );

      const output = '''
/// doc comment
String? get method {
  return maybeMap<String?>(
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello',
    one: '0',
    two: null,
    three: 'hello',
  );
}
''';

      expect(template.toString(), output);
    });

    test('should return non-nullable method', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: getValue,
        defaultValue: "'hello'",
        typeAsString: '$String',
        methodType: MethodType.maybeMap,
        docComment: '/// doc comment',
        allowNulls: false,
      );

      const output = '''
/// doc comment
String get method {
  return maybeMap<String>(
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello'!,
    one: '0',
    two: null,
    three: null,
  );
}
''';

      expect(template.toString(), output);
    });
  });
}
