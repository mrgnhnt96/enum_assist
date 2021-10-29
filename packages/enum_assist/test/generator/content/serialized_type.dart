import 'package:enum_assist_annotation/enum_assist_annotation.dart';

@EnumAssist()
enum TestEnum {
  @EnumValue(serializedValue: String)
  value1,
  @EnumValue(serializedValue: String)
  value2,
  @EnumValue(serializedValue: String)
  value3,
}
