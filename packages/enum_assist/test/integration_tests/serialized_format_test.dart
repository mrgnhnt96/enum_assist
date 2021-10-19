import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/serialized_format.dart';
import '../integration/util/util.dart';

void main() {
  const fileName = 'serialized_format';
  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  test('name should return camel case', () {
    const enumValue = Camel.formatEnum;

    expect(enumValue.serialized, 'formatEnum');
  });

  test('name should return capital case', () {
    const enumValue = Capital.formatEnum;

    expect(enumValue.serialized, 'Format Enum');
  });

  test('name should return constant case', () {
    const enumValue = Constant.formatEnum;

    expect(enumValue.serialized, 'FORMAT_ENUM');
  });

  test('name should return dot case', () {
    const enumValue = Dot.formatEnum;

    expect(enumValue.serialized, 'format.enum');
  });

  test('name should return header case', () {
    const enumValue = Header.formatEnum;

    expect(enumValue.serialized, 'Format-Enum');
  });

  test('name should return kebab case', () {
    const enumValue = Kebab.formatEnum;

    expect(enumValue.serialized, 'format-enum');
  });

  test('name should return no case', () {
    const enumValue = No.formatEnum;

    expect(enumValue.serialized, 'format enum');
  });

  test('name should return none case', () {
    const enumValue = None.formatEnum;

    expect(enumValue.serialized, 'formatEnum');
  });

  test('name should return pascal case', () {
    const enumValue = Pascal.formatEnum;

    expect(enumValue.serialized, 'FormatEnum');
  });

  test('name should return path case', () {
    const enumValue = Path.formatEnum;

    expect(enumValue.serialized, 'format/enum');
  });

  test('name should return sentence case', () {
    const enumValue = Sentence.formatEnum;

    expect(enumValue.serialized, 'Format enum');
  });

  test('name should return snake case', () {
    const enumValue = Snake.formatEnum;

    expect(enumValue.serialized, 'format_enum');
  });

  test('name should return swap case', () {
    const enumValue = Swap.formatEnum;

    expect(enumValue.serialized, 'FORMATeNUM');
  });
}
