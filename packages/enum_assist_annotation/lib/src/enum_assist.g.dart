// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_assist.dart';

// **************************************************************************
// JsonFieldsGenerator
// **************************************************************************

class _$EnumAssistFields {
  const _$EnumAssistFields();
  final String createJsonConv = 'create_json_conv';
  final String fieldFormat = 'field_format';
  final String useDocCommentAsDescription = 'use_doc_comment_as_description';
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumAssist _$EnumAssistFromJson(Map<String, dynamic> json) => EnumAssist(
      createJsonConv: json['create_json_conv'] as bool?,
      fieldFormat:
          _$enumDecodeNullable(_$FieldFormatEnumMap, json['field_format']),
      useDocCommentAsDescription:
          json['use_doc_comment_as_description'] as bool?,
    );

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$FieldFormatEnumMap = {
  FieldFormat.kebab: 'kebab',
  FieldFormat.snake: 'snake',
  FieldFormat.pascal: 'pascal',
  FieldFormat.none: 'none',
};
