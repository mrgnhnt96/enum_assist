import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/description_extension_template.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(index: 0, fieldName: 'one', description: 'description'),
    };
  });

  test('should return description template', () async {
    final template = DescriptionTemplate(enumName, fields);

    const output = '''
/// Returns the description of the enum field.
///
/// If the description is null, the doc comment of the enum field is returned.
String? get description {
  return map (
      one: \'''
description\''',
  );
}
''';

    expect(template.toString(), output);
  });
}
