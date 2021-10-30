import 'package:enum_assist/src/templates/templates.dart';
import 'package:test/test.dart';

void main() {
  late Iterable<String> fields;
  const enumName = 'enumName';

  setUp(() {
    fields = const {
      'one',
      'two',
      'three',
    };
  });

  test('should return map template', () async {
    final template = MapExtensionTemplate(enumName, fields);

    const output = '''
/// Map of all values of the enum
T map<T extends Object?> ({
  required T one,
  required T two,
  required T three,
}) {
  switch(this) {
    case enumName.one:
      return one;
    case enumName.two:
      return two;
    case enumName.three:
      return three;
  }
}
''';

    expect(template.toString(), output);
  });
}
