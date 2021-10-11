import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.g.dart';

@EnumAssist(
  fieldFormat: FieldFormat.snake,
)
enum Numbers {
  onetyOne,
  twothyTwo,
  threelyThree,
}
