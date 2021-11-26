import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_to_int.dart';

@EnumAssist(
  createToInt: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(
  createToInt: false,
)
enum Letters {
  @EnumValue(intValue: 0)
  handWritten,
  @EnumValue(intValue: 1)
  email,
  @EnumValue(intValue: 2)
  hate,
}

@EnumAssist(
  createToInt: false,
  useIntValueForSerialization: true,
)
enum Vehicle {
  @EnumValue(intValue: 0)
  car,
  @EnumValue(intValue: 1)
  plane,
  @EnumValue(intValue: 2)
  train,
}
