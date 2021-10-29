import 'package:enum_assist_annotation/enum_assist_annotation.dart';

@EnumAssist()
enum TestEnum {
  @EnumValue(serializedValue: {'0': 0})
  value1,
  @EnumValue(serializedValue: {'0': 0})
  value2,
  @EnumValue(serializedValue: {'0': 0})
  value3,
}
