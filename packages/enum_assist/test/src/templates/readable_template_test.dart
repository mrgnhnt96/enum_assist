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
        readableName: 'one name',
      ),
      FieldData.manual(
        index: 1,
        fieldName: 'two',
        readableName: 'two name',
      ),
      FieldData.manual(
        index: 2,
        fieldName: 'three',
        readableName: 'three name',
      ),
    };
  });

  test('should return readable template', () async {
    final template = ReadableTemplate(enumName, fields);

    const output = '''
/// Returns the name of the enum field
/// In a human readable format
String get readable {
  return map<String>(
    one: 'one name',
    two: 'two name',
    three: 'three name',
  );
}
''';

    expect(template.toString(), output);
  });
}
