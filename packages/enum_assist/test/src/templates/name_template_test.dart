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

  test('should return name template', () async {
    final template = NameTemplate(enumName, fields);

    const output = '''
/// Returns the name of the enum field
String get name {
  return map<String>(
    one: 'one',
    two: 'two',
    three: 'three',
  );
}
''';

    expect(template.toString(), output);
  });
}
