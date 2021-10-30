import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/maybe_map_template.dart';
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
    final template = MaybeMapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: (f) => '${f.index}',
      defaultValue: "'hello'",
      typeAsString: '$String',
      docComment: '',
      allowNulls: false,
    );

    const output = '''

String get method {
  return maybeMap (
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello'!,
      one: '0',
  );
}
''';

    expect(template.toString(), output);
  });

  test('should return nullable method', () {
    final template = MaybeMapTemplate(
      enumName,
      fields,
      methodName: 'method',
      getValue: (f) => '${f.index}',
      defaultValue: "'hello'",
      typeAsString: '$String',
      docComment: '',
      allowNulls: true,
    );

    const output = '''

String? get method {
  return maybeMap (
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: 'hello',
      one: '0',
  );
}
''';

    expect(template.toString(), output);
  });
}
