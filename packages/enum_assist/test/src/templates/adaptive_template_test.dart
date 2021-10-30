import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/adaptive_template.dart';
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
    };
  });

  group('map', () {
    test('should return non-nullable method', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: (f) => '${f.index}',
        defaultValue: null,
        typeAsString: '$String',
        methodType: MethodType.map,
        docComment: '/// doc comment',
        allowNulls: false,
      );

      const output = '''
/// doc comment
String get method {
  return map (
      one: '0',
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
        getValue: (f) => '${f.index}',
        defaultValue: null,
        typeAsString: '$String',
        methodType: MethodType.map,
        docComment: '/// doc comment',
        allowNulls: true,
      );

      const output = '''
/// doc comment
String? get method {
  return map (
      one: '0',
  );
}
''';

      expect(template.toString(), output);
    });
  });

  group('maybeMap', () {
    test('should return non-nullable method', () {
      final template = AdaptiveTemplate(
        enumName,
        fields,
        methodName: 'method',
        getValue: (f) => '${f.index}',
        defaultValue: "'hello'",
        typeAsString: '$String',
        methodType: MethodType.maybeMap,
        docComment: '',
        allowNulls: false,
      );

      const output = '''

String get method {
  return maybeMap (
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello'!,
      one: '0',
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
        getValue: (f) => '${f.index}',
        defaultValue: "'hello'",
        typeAsString: '$String',
        methodType: MethodType.maybeMap,
        docComment: '',
        allowNulls: true,
      );

      const output = '''

String? get method {
  return maybeMap (
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello',
      one: '0',
  );
}
''';

      expect(template.toString(), output);
    });
  });
}
