import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'int_value.ge.dart';

@EnumAssist()
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist()
enum Letters {
  @EnumValue(intValue: 0)
  handWritten,
  @EnumValue(intValue: 1)
  email,
  @EnumValue(intValue: 2)
  hate,
}

@EnumAssist()
enum Familia {
  @EnumValue(intValue: 3)
  madre,
  padre,
  hijo,
}

@EnumAssist()
enum Candy {
  @EnumValue(intValue: 6)
  skittles,
  butterfinger,
  reeses,
}

@EnumAssist()
enum Soda {
  coke,
  @EnumValue(intValue: 200)
  pepsi,
  sprite,
  @EnumValue(intValue: 4)
  fanta,
}
