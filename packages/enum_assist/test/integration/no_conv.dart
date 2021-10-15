import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'no_conv.ge.dart';

@EnumAssist(
  createJsonConv: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}
