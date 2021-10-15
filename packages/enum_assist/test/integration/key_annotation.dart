import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'key_annotation.ge.dart';

@EnumAssist()
enum Animal {
  @EnumKey(
    name: 'Doggy',
    description: 'Doggy description',
    serializedValue: 'doggy',
  )
  dog,
  @EnumKey(
    name: 'Kitty',
    description: 'Kitty description',
    serializedValue: 'kitty',
  )
  cat,
  @EnumKey(
    name: 'Mousy',
    description: 'Mousy description',
    serializedValue: 'mousy',
  )
  mouse,
}
