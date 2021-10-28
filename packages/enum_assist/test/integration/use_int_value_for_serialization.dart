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
  @EnumKey(serializedValue: 'handWritten')
  handWritten,
  @EnumKey(serializedValue: 'email')
  email,
  @EnumKey(serializedValue: 'hate')
  hate,
}

@EnumAssist(useIntValueForSerialization: true)
enum Familia {
  @EnumKey(intValue: 101)
  madre,
  padre,
  hijo,
}

@EnumAssist(useIntValueForSerialization: true)
enum Candy {
  @EnumKey(serializedValue: 'Familia.madre')
  skittles,
  @EnumKey(serializedValue: null, intValue: 200)
  butterfinger,
  @EnumKey(serializedValue: 1)
  reeses,
}
