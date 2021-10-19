import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('$MaybeExtension', () {
    late MaybeExtension extension;

    setUp(() {
      extension = _TestMaybe();
    });

    test('#methodType should return maybeMap', () {
      expect(extension.methodType, MethodType.maybeMap);
    });

    test('should allow non nullable type', () {
      expect(extension.allowNulls, isFalse);
    });

    test('should allow nullable type', () {
      final nullableExt = _TestNullMaybe();

      expect(nullableExt.allowNulls, isTrue);
    });
  });

  group('$MapExtension', () {
    late MapExtension extension;

    setUp(() {
      extension = _TestMap();
    });

    test('#methodType should return map', () {
      expect(extension.methodType, MethodType.map);
    });

    test('should allow non nullable type', () {
      expect(extension.allowNulls, isFalse);
    });

    test('should allow nullable type', () {
      final nullableExt = _TestNullMap();

      expect(nullableExt.allowNulls, isTrue);
    });
  });
}

class _TestMaybe extends MaybeExtension<String> {
  _TestMaybe()
      : super(
          'value',
          methodName: 'test maybe',
          defaultValue: 'default',
        );
}

class _TestMap extends MapExtension<String> {
  _TestMap()
      : super(
          'value',
          methodName: 'test maybe',
        );
}

class _TestNullMaybe extends MaybeExtension<String> {
  _TestNullMaybe()
      : super(
          'value',
          methodName: 'test maybe',
          defaultValue: 'default',
          allowNulls: true,
        );
}

class _TestNullMap extends MapExtension<String> {
  _TestNullMap()
      : super(
          'value',
          methodName: 'test maybe',
          allowNulls: true,
        );
}
