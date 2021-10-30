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

  test('should return maybe map template', () async {
    final template = MaybeMapExtensionTemplate(enumName, fields);

    const output = '''
/// Optionally map all values of the enum
///
/// default value is provided when value has not been mapped
T maybeMap<T extends Object?> ({
  required T orElse,
  T? one,
  T? two,
  T? three,
}) {
  var isNullable = true;
  try {
    final value = null as T;
  }
  catch (_) {
    isNullable = false;
  }

  switch(this) {
    case enumName.one:
      if (one == null && !isNullable) return orElse;
      return one as T;
    case enumName.two:
      if (two == null && !isNullable) return orElse;
      return two as T;
    case enumName.three:
      if (three == null && !isNullable) return orElse;
      return three as T;
  }
}
''';

    expect(template.toString(), output);
  });
}
