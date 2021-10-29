import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import '../integration/serialized_format.dart';
import '../util/util.dart';

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

  test('should return camel case', () {
    const enumValue = Camel.formatEnum;

    expect(enumValue.serialized, 'formatEnum');
  });

  test('should return capital case', () {
    const enumValue = Capital.formatEnum;

    expect(enumValue.serialized, 'Format Enum');
  });

  test('should return constant case', () {
    const enumValue = Constant.formatEnum;

    expect(enumValue.serialized, 'FORMAT_ENUM');
  });

  test('should return dot case', () {
    const enumValue = Dot.formatEnum;

    expect(enumValue.serialized, 'format.enum');
  });

  test('should return header case', () {
    const enumValue = Header.formatEnum;

    expect(enumValue.serialized, 'Format-Enum');
  });

  test('should return kebab case', () {
    const enumValue = Kebab.formatEnum;

    expect(enumValue.serialized, 'format-enum');
  });

  test('should return no case', () {
    const enumValue = No.formatEnum;

    expect(enumValue.serialized, 'format enum');
  });

  test('should return none case', () {
    const enumValue = None.formatEnum;

    expect(enumValue.serialized, 'formatEnum');
  });

  test('should return pascal case', () {
    const enumValue = Pascal.formatEnum;

    expect(enumValue.serialized, 'FormatEnum');
  });

  test('should return path case', () {
    const enumValue = Path.formatEnum;

    expect(enumValue.serialized, 'format/enum');
  });

  test('should return sentence case', () {
    const enumValue = Sentence.formatEnum;

    expect(enumValue.serialized, 'Format enum');
  });

  test('should return snake case', () {
    const enumValue = Snake.formatEnum;

    expect(enumValue.serialized, 'format_enum');
  });

  test('should return swap case', () {
    const enumValue = Swap.formatEnum;

    expect(enumValue.serialized, 'FORMATeNUM');
  });
}
