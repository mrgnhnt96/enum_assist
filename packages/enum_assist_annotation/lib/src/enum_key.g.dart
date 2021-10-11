// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_key.dart';

// **************************************************************************
// JsonFieldsGenerator
// **************************************************************************

class _$EnumKeyFields {
  const _$EnumKeyFields();
  final String name = 'name';
  final String description = 'description';
  final String serializedValue = 'serializedValue';
  final String useDocCommentAsDescription = 'useDocCommentAsDescription';
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumKey _$EnumKeyFromJson(Map<String, dynamic> json) => EnumKey(
      name: json['name'] as String?,
      description: json['description'] as String?,
      serializedValue: json['serializedValue'] as String?,
      useDocCommentAsDescription: json['useDocCommentAsDescription'] as bool?,
    );
