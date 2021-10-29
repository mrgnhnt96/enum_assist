import 'package:enum_assist_annotation/enum_assist_annotation.dart';

@EnumAssist()
enum TestEnum {
  @EnumValue(serializedValue: false)
  value1,
  @EnumValue(serializedValue: false)
  value2,
  @EnumValue(serializedValue: false)
  value3,
}
