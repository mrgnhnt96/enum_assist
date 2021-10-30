import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/map_template.dart';
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

  test('should return non-nullable method', () {
    final template = MapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: (f) => '${f.index}',
      typeAsString: '$String',
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
    final template = MapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: (f) => '${f.index}',
      typeAsString: '$String',
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
}
