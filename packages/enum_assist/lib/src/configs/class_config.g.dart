// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassConfig _$ClassConfigFromJson(Map<String, dynamic> json) => ClassConfig(
      createJsonConv: json['create_json_conv'] as bool,
      fieldFormat: _$enumDecode(_$FieldFormatEnumMap, json['field_format']),
      useDocCommentAsDescription:
          json['use_doc_comment_as_description'] as bool,
      additionalMethods: (json['additional_methods'] as List<dynamic>?)
          ?.map((e) => AdditionalMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassConfigToJson(ClassConfig instance) =>
    <String, dynamic>{
      'create_json_conv': instance.createJsonConv,
      'field_format': _$FieldFormatEnumMap[instance.fieldFormat],
      'use_doc_comment_as_description': instance.useDocCommentAsDescription,
      'additional_methods': instance.additionalMethods,
    };

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

const _$FieldFormatEnumMap = {
  FieldFormat.kebab: 'kebab',
  FieldFormat.snake: 'snake',
  FieldFormat.pascal: 'pascal',
  FieldFormat.none: 'none',
};
