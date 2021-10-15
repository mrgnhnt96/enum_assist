import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import 'integration/util/util.dart';

void main() {
  const fileName = 'no_conv';
  const enumName = 'Animal';

  late LibraryElement main;

  setUp(() async {
    main = await getLibraryElement(fileName);
  });

  test('has no issue', () async {
    final errorResult = await main.getErrorResults(fileName);

    expect(errorResult.errors, isEmpty);
  });

  group('JsonConverter', () {
    test('AnimalConv should not exist', () {
      expect(main.doesConvExist(enumName), isFalse);
    });

    test('AnimalNullableConv should not exist', () {
      expect(main.doesConvNullableExist(enumName), isFalse);
    });
  });
}
