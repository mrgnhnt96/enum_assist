import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'key_annotation.ge.dart';

@EnumAssist()
enum Animal {
  @EnumValue(
    readable: 'Doggy',
    description: 'Doggy description',
    serializedValue: 'doggy',
  )
  dog,
  @EnumValue(
    readable: 'Kitty',
    description: 'Kitty description',
    serializedValue: 'kitty',
  )
  cat,
  @EnumValue(
    readable: 'Mousy',
    description: 'Mousy description',
    serializedValue: 'mousy',
  )
  mouse,
}
