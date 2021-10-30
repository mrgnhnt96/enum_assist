import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/description_extension_template.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(
        index: 0,
        fieldName: 'one',
        description: 'description for one',
      ),
      FieldData.manual(
        index: 1,
        fieldName: 'two',
        description: 'description for two',
      ),
      FieldData.manual(
        index: 2,
        fieldName: 'three',
        description: 'description for three',
      ),
    };
  });

  test('should return description template', () async {
    final template = DescriptionTemplate(enumName, fields);

    const output = '''
/// Returns the description of the enum field.
///
/// If the description is null, the doc comment of the enum field is returned.
String? get description {
  return map<String?>(
    one: \'''
description for one\''',
    two: \'''
description for two\''',
    three: \'''
description for three\''',
  );
}
''';

    expect(template.toString(), output);
  });
}
