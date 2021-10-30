import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/int_extension_template.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<FieldData> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      FieldData.manual(
        index: 0,
        fieldName: 'one',
        intValue: 1,
      ),
      FieldData.manual(
        index: 1,
        fieldName: 'two',
        intValue: 2,
      ),
      FieldData.manual(
        index: 2,
        fieldName: 'three',
        intValue: 3,
      ),
    };
  });

  test('should return int value template', () async {
    final template = IntValueTemplate(enumName, fields);

    const output = '''
/// The enum value converted to an integer
int get toInt {
  return map<int>(
    one: 1,
    two: 2,
    three: 3,
  );
}
''';

    expect(template.toString(), output);
  });
}
