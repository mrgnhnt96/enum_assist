import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('#defaults', () {
    final defaults = ClassConfig.defaults;

    test('createJsonConv should return true', () {
      expect(defaults.createJsonConv, isTrue);
    });

    test('serializedFormat should return SerializedFormat.none', () {
      expect(defaults.serializedFormat, SerializedFormat.none);
    });

    test('useDocCommentAsDescription should return true', () {
      expect(defaults.useDocCommentAsDescription, isTrue);
    });

    test('additionalExtensions should return empty list', () {
      expect(defaults.additionalExtensions, isEmpty);
    });
  });
}
