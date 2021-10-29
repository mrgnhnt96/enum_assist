import 'package:enum_assist/src/src.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'utils/generate_file.dart';

void main() {
  group('$InvalidGenerationSourceError', () {
    test('should throw when annotation is not for enum', () async {
      expect(() => generateFile('non_enum'),
          throwsA(isA<InvalidGenerationSourceError>()));
    });
  });

  group('$DuplicateMethodException', () {
    test('should throw when duplicate is present', () async {
      expect(() => generateFile('duplicate_method'),
          throwsA(isA<DuplicateMethodException>()));
    });
  });

  group('$DuplicateExtensionException', () {
    test('should throw when duplicate is present', () async {
      expect(() => generateFile('duplicate_extension'),
          throwsA(isA<DuplicateExtensionException>()));
    });
  });

  group('$NullReturnedOnNonNullException', () {
    test('should throw when value is null & allowNulls is false', () async {
      expect(() => generateFile('missing_value'),
          throwsA(isA<NullReturnedOnNonNullException>()));
    });
  });

  group('$MissingDeclaredExtensionException', () {
    test('should throw when declaration is missing', () async {
      expect(() => generateFile('missing_declaration'),
          throwsA(isA<MissingDeclaredExtensionException>()));
    });
  });

  group('$InvalidSerializedTypeException', () {
    test('should throw when serialized value is bool', () async {
      expect(() => generateFile('serialized_bool'),
          throwsA(isA<InvalidSerializedTypeException>()));
    });

    test('should throw when serialized value is double', () async {
      expect(() => generateFile('serialized_double'),
          throwsA(isA<InvalidSerializedTypeException>()));
    });

    test('should throw when serialized value is List', () async {
      expect(() => generateFile('serialized_list'),
          throwsA(isA<InvalidSerializedTypeException>()));
    });

    test('should throw when serialized value is Map', () async {
      expect(() => generateFile('serialized_map'),
          throwsA(isA<InvalidSerializedTypeException>()));
    });
  });
}
