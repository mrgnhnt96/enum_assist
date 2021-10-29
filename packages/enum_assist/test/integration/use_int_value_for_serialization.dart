import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'use_int_value_for_serialization.ge.dart';

@EnumAssist(useIntValueForSerialization: true)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(useIntValueForSerialization: true)
enum Letters {
  @EnumValue(serializedValue: 'handWritten')
  handWritten,
  @EnumValue(serializedValue: 'email')
  email,
  @EnumValue(serializedValue: 'hate')
  hate,
}

@EnumAssist(useIntValueForSerialization: true)
enum Familia {
  @EnumValue(intValue: 101)
  madre,
  padre,
  hijo,
}

@EnumAssist(useIntValueForSerialization: true)
enum Candy {
  @EnumValue(serializedValue: 'Familia.madre')
  skittles,
  @EnumValue(serializedValue: null, intValue: 200)
  butterfinger,
  @EnumValue(serializedValue: 1)
  reeses,
}
