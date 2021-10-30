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

  test('should return name template', () async {
    final template = NameTemplate(enumName, fields);

    const output = '''
/// Returns the name of the enum field
String get name {
  return map (
      one: 'one',
  );
}
''';

    expect(template.toString(), output);
  });
}
