import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/maybe_map_template.dart';
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

  test('should return value', () {
    final template = MaybeMapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: getValue,
      defaultValue: "'hello'",
      typeAsString: '$String',
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
    final template = MaybeMapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: getValue,
      defaultValue: "'hello'",
      typeAsString: '$String',
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
}
