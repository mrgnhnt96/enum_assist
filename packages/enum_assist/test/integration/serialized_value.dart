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
  @EnumKey(serializedValue: 'handWritten')
  handWritten,
  @EnumKey(serializedValue: 'email')
  email,
  @EnumKey(serializedValue: 'hate')
  hate,
}

@EnumAssist()
enum Familia {
  @EnumKey(serializedValue: 1)
  madre,
  @EnumKey(serializedValue: 2)
  padre,
  @EnumKey(serializedValue: 3)
  hijo,
}

@EnumAssist()
enum Candy {
  @EnumKey(serializedValue: 'Familia.madre')
  skittles,
  @EnumKey(serializedValue: null)
  butterfinger,
  @EnumKey(serializedValue: 1 as int)
  reeses,
  @EnumKey(serializedValue: 2 as num)
  kitkat,
  @EnumKey(serializedValue: 3)
  snickers,
}
