import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_name.dart';

@EnumAssist(
  createName: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}
