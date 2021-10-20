import 'package:enum_assist/src/util/match_bracket.dart';
import 'package:test/test.dart';

void main() {
  test('matches nothing', () {
    const str = '';

    final bracket = matchBracket(str, '(');

    expect(bracket?.contents, isNull);
  });

  group('ignores in string', () {
    test('multistring', () {
      const str = "'''hello (world)'''";

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, isNull);
    });

    test('parenthesis', () {
      const str = "'hello (world)'";

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, isNull);
    });

    test('square brackets', () {
      const str = "'hello [world]'";

      final bracket = matchBracket(str, '[');

      expect(bracket?.contents, isNull);
    });

    test('curly brackets', () {
      const str = "'hello {world}'";

      final bracket = matchBracket(str, '{');

      expect(bracket?.contents, isNull);
    });

    test('carrot', () {
      const str = "'hello <world>'";

      final bracket = matchBracket(str, '<');

      expect(bracket?.contents, isNull);
    });
  });

  group('returns content within first set', () {
    group('string', () {
      test('parenthesis', () {
        const content = "'hello (world)'";
        const str = '($content)';

        final bracket = matchBracket(str, '(');

        expect(bracket?.contents, content);
      });

      test('square brackets', () {
        const content = "'hello [world]'";
        const str = '[$content]';

        final bracket = matchBracket(str, '[');

        expect(bracket?.contents, content);
      });

      test('curly brackets', () {
        const content = "'hello {world}'";
        const str = '{$content}';

        final bracket = matchBracket(str, '{');

        expect(bracket?.contents, content);
      });

      test('carrot', () {
        const content = "'hello <world>'";
        const str = '<$content>';

        final bracket = matchBracket(str, '<');

        expect(bracket?.contents, content);
      });
    });

    group('brackets', () {
      test('parenthesis', () {
        const content = 'hello (world)';
        const str = '($content)';

        final bracket = matchBracket(str, '(');

        expect(bracket?.contents, content);
      });

      test('square brackets', () {
        const content = 'hello [world]';
        const str = '[$content]';

        final bracket = matchBracket(str, '[');

        expect(bracket?.contents, content);
      });

      test('curly brackets', () {
        const content = 'hello {world}';
        const str = '{$content}';

        final bracket = matchBracket(str, '{');

        expect(bracket?.contents, content);
      });

      test('carrot', () {
        const content = 'hello <world>';
        const str = '<$content>';

        final bracket = matchBracket(str, '<');

        expect(bracket?.contents, content);
      });
    });
  });

  group('returns content within second set', () {
    test('parenthesis', () {
      const content = 'world';
      const str = '(hello ($content))';

      final bracket = matchBracket(str, ')', 1);

      expect(bracket?.contents, content);
    });

    test('square brackets', () {
      const content = 'world';
      const str = '[hello [$content]]';

      final bracket = matchBracket(str, ']', 1);

      expect(bracket?.contents, content);
    });

    test('curly brackets', () {
      const content = 'world';
      const str = '{hello {$content}}';

      final bracket = matchBracket(str, '}', 1);

      expect(bracket?.contents, content);
    });

    test('carrot', () {
      const content = 'world';
      const str = '<hello <$content>>';

      final bracket = matchBracket(str, '>', 1);

      expect(bracket?.contents, content);
    });
  });

  group('returns content within class', () {
    test('positioned literal', () {
      const content = '123';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('named literal', () {
      const content = 'a: 123';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('positioned class', () {
      const content = 'MyClass()';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('named class', () {
      const content = 'a: MyClass()';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('positioned class with positioned value', () {
      const content = 'MyClass(123)';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('named class with positioned value', () {
      const content = 'a: MyClass(123)';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('positioned class with named value', () {
      const content = 'MyClass(a: 123)';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });

    test('named class with named value', () {
      const content = 'a: MyClass(a: 123)';
      const str = 'MyClass($content)';

      final bracket = matchBracket(str, '(');

      expect(bracket?.contents, content);
    });
  });

  group('gets first complete set', () {
    test('parenthesis', () {
      const content = 'hello';
      const str = '($content) (world)';

      final bracket = matchBracket(str, ')', 0);

      expect(bracket?.contents, content);
    });

    test('square brackets', () {
      const content = 'hello';
      const str = '[$content] [world]';

      final bracket = matchBracket(str, ']', 0);

      expect(bracket?.contents, content);
    });

    test('curly brackets', () {
      const content = 'hello';
      const str = '{$content} {world}';

      final bracket = matchBracket(str, '}', 0);

      expect(bracket?.contents, content);
    });

    test('carrot', () {
      const content = 'hello';
      const str = '<$content> <world>';

      final bracket = matchBracket(str, '>', 0);

      expect(bracket?.contents, content);
    });

    group('contains set within', () {
      test('parenthesis', () {
        const content = 'hello(awesome)';
        const str = '($content) (world)';

        final bracket = matchBracket(str, ')', 0);

        expect(bracket?.contents, content);
      });

      test('square brackets', () {
        const content = 'hello(awesome)';
        const str = '[$content] [world]';

        final bracket = matchBracket(str, ']', 0);

        expect(bracket?.contents, content);
      });

      test('curly brackets', () {
        const content = 'hello(awesome)';
        const str = '{$content} {world}';

        final bracket = matchBracket(str, '}', 0);

        expect(bracket?.contents, content);
      });

      test('carrot', () {
        const content = 'hello(awesome)';
        const str = '<$content> <world>';

        final bracket = matchBracket(str, '>', 0);

        expect(bracket?.contents, content);
      });
    });
  });
}
