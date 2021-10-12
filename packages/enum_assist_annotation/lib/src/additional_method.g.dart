// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_method.dart';

// **************************************************************************
// JsonFieldsGenerator
// **************************************************************************

class _$AdditionalMethodFields {
  const _$AdditionalMethodFields();
  final String methodName = 'methodName';
  final String defaultValue = 'defaultValue';
  final String isNullable = 'isNullable';
}

class _$AdditionalMaybeMapMethodFields {
  const _$AdditionalMaybeMapMethodFields();
  final String methodName = 'methodName';
  final String defaultValue = 'defaultValue';
  final String isNullable = 'isNullable';
  final String value = 'value';
}

class _$AdditionalMapMethodFields {
  const _$AdditionalMapMethodFields();
  final String methodName = 'methodName';
  final String defaultValue = 'defaultValue';
  final String isNullable = 'isNullable';
  final String value = 'value';
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalMethod _$AdditionalMethodFromJson(Map<String, dynamic> json) =>
    AdditionalMethod(
      defaultValue: json['defaultValue'] as Object,
      methodName: json['methodName'] as String,
      isNullable: json['isNullable'] as bool,
    );

Map<String, dynamic> _$AdditionalMethodToJson(AdditionalMethod instance) =>
    <String, dynamic>{
      'methodName': instance.methodName,
      'defaultValue': instance.defaultValue,
      'isNullable': instance.isNullable,
    };

AdditionalMaybeMapMethod _$AdditionalMaybeMapMethodFromJson(
        Map<String, dynamic> json) =>
    AdditionalMaybeMapMethod(
      value: json['value'],
      defaultValue: json['defaultValue'] as String,
      methodName: json['methodName'] as String,
      isNullable: json['isNullable'] as bool,
    );

Map<String, dynamic> _$AdditionalMaybeMapMethodToJson(
    AdditionalMaybeMapMethod instance) {
  final val = <String, dynamic>{
    'methodName': instance.methodName,
    'defaultValue': instance.defaultValue,
    'isNullable': instance.isNullable,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  return val;
}

AdditionalMapMethod _$AdditionalMapMethodFromJson(Map<String, dynamic> json) =>
    AdditionalMapMethod(
      value: json['value'] as Object,
      defaultValue: json['defaultValue'] as String,
      methodName: json['methodName'] as String,
    );

Map<String, dynamic> _$AdditionalMapMethodToJson(
        AdditionalMapMethod instance) =>
    <String, dynamic>{
      'methodName': instance.methodName,
      'defaultValue': instance.defaultValue,
      'value': instance.value,
    };
