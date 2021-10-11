// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_assist.dart';

// **************************************************************************
// JsonFieldsGenerator
// **************************************************************************

class _$EnumAssistFields {
  const _$EnumAssistFields();
  final String createJsonConv = 'createJsonConv';
  final String fieldFormat = 'fieldFormat';
  final String useDocCommentAsDescription = 'useDocCommentAsDescription';
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumAssist _$EnumAssistFromJson(Map<String, dynamic> json) => EnumAssist(
      createJsonConv: json['createJsonConv'] as bool?,
      fieldFormat:
          _$enumDecodeNullable(_$FieldFormatEnumMap, json['fieldFormat']),
      useDocCommentAsDescription: json['useDocCommentAsDescription'] as bool?,
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
