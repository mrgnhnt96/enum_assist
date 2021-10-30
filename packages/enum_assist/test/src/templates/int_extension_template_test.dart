import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/int_extension_template.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(index: 0, fieldName: 'one', intValue: 1),
    };
  });

  test('should return int value template', () async {
    final template = IntValueTemplate(enumName, fields);

    const output = '''
/// The enum value converted to an integer
int get toInt {
  return map (
      one: 1,
  );
}
''';

    expect(template.toString(), output);
  });
}
