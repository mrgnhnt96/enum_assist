import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'key_annotation.ge.dart';

@EnumAssist()
enum Animal {
  @EnumKey(
    readable: 'Doggy',
    description: 'Doggy description',
    serializedValue: 'doggy',
  )
  dog,
  @EnumKey(
    readable: 'Kitty',
    description: 'Kitty description',
    serializedValue: 'kitty',
  )
  cat,
  @EnumKey(
    readable: 'Mousy',
    description: 'Mousy description',
    serializedValue: 'mousy',
  )
  mouse,
}
