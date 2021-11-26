import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_json_conv.dart';

@EnumAssist(
  createJsonConv: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(
  createJsonConv: false,
)
enum Letters {
  @EnumValue(serializedValue: 'handWrittenValue')
  handWritten,
  @EnumValue(serializedValue: 'emailValue')
  email,
  @EnumValue(serializedValue: 'hateValue')
  hate,
}
