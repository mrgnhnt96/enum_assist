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

  test('should return readable template with value from conv class', () async {
    final template = SerializedTemplate(
      enumName,
      fields,
      createJsonConv: true,
    );

    const output = '''
/// Returns the serialized value of the enum field.
Object get serialized {
  return map (
      one: enumNameConv._oneName,
  );
}
''';

    expect(template.toString(), output);
  });

  test('should return readable template with value from field', () async {
    final template = SerializedTemplate(
      enumName,
      fields,
      createJsonConv: false,
    );

    const output = '''
/// Returns the serialized value of the enum field.
Object get serialized {
  return map (
      one: 'one',
  );
}
''';

    expect(template.toString(), output);
  });
}
