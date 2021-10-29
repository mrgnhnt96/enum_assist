import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'create_json_conv.ge.dart';

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

@EnumAssist()
enum Vehicle {
  car,
  plane,
  train,
}
