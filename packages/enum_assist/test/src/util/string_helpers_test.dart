import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('#tab', () {
    test('should return intended string by default', () {
      const string = 'foo';

      expect(tab(string), '  $string');
    });

    test('should return non indented string when 0 provided', () {
      const string = 'foo';

      expect(tab(string, 0), string);
    });

    test('should return indented string when positive number provided', () {
      const string = 'foo';
      const indent = '  ';
      const count = 2;

      expect(tab(string, count), '${indent * count}$string');
    });

    test('should return non indented string when negative number provided', () {
      const string = 'foo';

      expect(tab(string, -2), string);
    });
  });

  test('#tabIndentation is 2 spaces', () {
    expect(tabIndentation, '  ');
  });

  group('#prepareValueForGen', () {
    test('should return type as string', () {
      const value = 21;

      expect(prepareValueForGen(value), '$value');
    });

    test('should add quotation marks to string types', () {
      const value = 'this is cosmos string!';

      expect(prepareValueForGen(value), "'$value'");
    });

    test('should add quotes to empty string', () {
      const value = '';

      expect(prepareValueForGen(value), "''");
    });
  });

  group('#isTypeAsStringNullable', () {
    test('should return true when is nullable', () {
      const types = [
        'String?',
        'int?',
        'double?',
        'bool?',
        'DateTime?',
        'Duration?',
        'MyClass?',
        'MyEnum?',
        'SomeOtherCoolType?',
      ];

      for (final type in types) {
        expect(isTypeAsStringNullable(type), isTrue);
      }
    });

    test('should return false when is not nullable', () {
      const types = [
        'String',
        'int',
        'double',
        'bool',
        'DateTime',
        'Duration',
        'MyClass',
        'MyEnum',
        'SomeOtherCoolType',
      ];

      for (final type in types) {
        expect(isTypeAsStringNullable(type), isFalse);
      }
    });
  });
}
