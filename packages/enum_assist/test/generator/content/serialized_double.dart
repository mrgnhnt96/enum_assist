import 'package:enum_assist_annotation/enum_assist_annotation.dart';

@EnumAssist()
enum TestEnum {
  @EnumValue(serializedValue: 1.01)
  value1,
  @EnumValue(serializedValue: 1.01)
  value2,
  @EnumValue(serializedValue: 1.01)
  value3,
}
