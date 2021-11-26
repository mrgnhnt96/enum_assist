import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_serialized.dart';

@EnumAssist(
  createSerialized: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(
  createSerialized: false,
)
enum Letters {
  @EnumValue(serializedValue: 'handWrittenValue')
  handWritten,
  @EnumValue(serializedValue: 'emailValue')
  email,
  @EnumValue(serializedValue: 'hateValue')
  hate,
}
