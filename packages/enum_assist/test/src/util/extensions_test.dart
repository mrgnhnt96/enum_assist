import 'package:enum_assist/src/util/util.dart';
import 'package:test/test.dart';

void main() {
  group('#StringBufferX', () {
    late StringBuffer sb;

    setUp(() {
      sb = StringBuffer();
    });

    group('#writelnTab', () {
      test('should return intended string by default', () {
        const string = 'foo';
        sb.writelnTab(string);

        expect(sb.toString(), '  $string\n');
      });

      test('should return non indented string when 0 provided', () {
        const string = 'foo';
        sb.writelnTab(string, 0);

        expect(sb.toString(), '$string\n');
      });

      test('should return indented string when positive number provided', () {
        const string = 'foo';
        const indent = '  ';
        const count = 2;

        sb.writelnTab(string, count);

        expect(sb.toString(), '${indent * count}$string\n');
      });

      test('should return non indented string when negative number provided',
          () {
        const string = 'foo';
        sb.writelnTab(string, -1);

        expect(sb.toString(), '$string\n');
      });
    });

    group('#writeTab', () {
      test('should return intended string by default', () {
        const string = 'foo';
        sb.writeTab(string);

        expect(sb.toString(), '  $string');
      });

      test('should return non indented string when 0 provided', () {
        const string = 'foo';
        sb.writeTab(string, 0);

        expect(sb.toString(), string);
      });

      test('should return indented string when positive number provided', () {
        const string = 'foo';
        const indent = '  ';
        const count = 2;

        sb.writeTab(string, count);

        expect(sb.toString(), '${indent * count}$string');
      });

      test('should return non indented string when negative number provided',
          () {
        const string = 'foo';
        sb.writeTab(string, -1);

        expect(sb.toString(), string);
      });
    });

    group('writeobj', () {
      test('should return before string with wrapped body and new lines', () {
        const string = 'foo';
        const body = 'body';
        sb.writeobj(
          string,
          body: (p0, p1) {
            p0.writeln(body);
          },
        );

        const expected = '$string {\n$body\n}\n';

        expect(sb.toString(), expected);
      });

      test('should not append new line', () {
        const string = 'foo';
        const body = 'body';
        sb.writeobj(
          string,
          appendNewLine: false,
          body: (p0, p1) {
            p0.writeln(body);
          },
        );

        const expected = '$string {\n$body\n}';

        expect(sb.toString(), expected);
      });

      test('should change open and close strings', () {
        const string = 'foo';
        const body = 'body';
        const open = '(';
        const close = ')';

        sb.writeobj(
          string,
          open: open,
          close: close,
          body: (p0, p1) {
            p0.writeln(body);
          },
        );

        const expected = '$string $open\n$body\n$close\n';

        expect(sb.toString(), expected);
      });

      test('should add one tab to each string when 1 is provided', () {
        const string = 'foo';
        const body = 'body';
        sb.writeobj(
          string,
          tab: 1,
          body: (p0, p1) {
            p0.writelnTab(body, p1);
          },
        );

        const expected = '  $string {\n    $body\n  }\n';

        expect(sb.toString(), expected);
      });

      test('should remove space between open and first string', () {
        const string = 'foo';
        const body = 'body';
        sb.writeobj(
          string,
          includeSpaceBetweenOpen: false,
          body: (p0, p1) {
            p0.writeln(body);
          },
        );

        const expected = '$string{\n$body\n}\n';

        expect(sb.toString(), expected);
      });
    });
  });
}
