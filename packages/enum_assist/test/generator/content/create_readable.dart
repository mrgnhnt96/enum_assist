import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_readable.dart';

@EnumAssist(
  createReadable: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(
  createReadable: false,
)
enum Letters {
  @EnumValue(readable: 'Hand written letter')
  handWritten,
  @EnumValue(readable: 'Email letter')
  email,
  @EnumValue(readable: 'Hate letter')
  hate,
}
