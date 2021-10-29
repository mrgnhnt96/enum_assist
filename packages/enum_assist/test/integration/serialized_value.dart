// ignore_for_file: unnecessary_cast
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'serialized_value.ge.dart';

@EnumAssist()
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist()
enum Letters {
  @EnumValue(serializedValue: 'handWritten')
  handWritten,
  @EnumValue(serializedValue: 'email')
  email,
  @EnumValue(serializedValue: 'hate')
  hate,
}

@EnumAssist()
enum Familia {
  @EnumValue(serializedValue: 1)
  madre,
  @EnumValue(serializedValue: 2)
  padre,
  @EnumValue(serializedValue: 3)
  hijo,
}

@EnumAssist()
enum Candy {
  @EnumValue(serializedValue: 'Familia.madre')
  skittles,
  @EnumValue(serializedValue: null)
  butterfinger,
  @EnumValue(serializedValue: 1 as int)
  reeses,
  @EnumValue(serializedValue: 2 as num)
  kitkat,
  @EnumValue(serializedValue: 3)
  snickers,
}
