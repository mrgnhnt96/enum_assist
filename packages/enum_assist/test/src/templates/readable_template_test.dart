import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/templates.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(index: 0, fieldName: 'one', intValue: 1),
    };
  });

  test('should return readable template', () async {
    final template = ReadableTemplate(enumName, fields);

    const output = '''
/// Returns the name of the enum field
/// In a human readable format
String get readable {
  return map (
      one: 'One',
  );
}
''';

    expect(template.toString(), output);
  });
}
