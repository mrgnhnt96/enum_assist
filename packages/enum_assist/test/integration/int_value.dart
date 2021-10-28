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
  @EnumKey(intValue: 0)
  handWritten,
  @EnumKey(intValue: 1)
  email,
  @EnumKey(intValue: 2)
  hate,
}

@EnumAssist()
enum Familia {
  @EnumKey(intValue: 3)
  madre,
  padre,
  hijo,
}

@EnumAssist()
enum Candy {
  @EnumKey(intValue: 6)
  skittles,
  butterfinger,
  reeses,
}

@EnumAssist()
enum Soda {
  coke,
  @EnumKey(intValue: 200)
  pepsi,
  sprite,
  @EnumKey(intValue: 4)
  fanta,
}
