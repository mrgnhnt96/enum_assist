import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'output/create_description.dart';

@EnumAssist(
  createDescription: false,
)
enum Animal {
  dog,
  cat,
  mouse,
}

@EnumAssist(
  createDescription: false,
)
enum Letters {
  @EnumValue(description: 'handWritten description')
  handWritten,
  @EnumValue(description: 'email description')
  email,
  @EnumValue(description: 'hate description')
  hate,
}

@EnumAssist(
  createDescription: false,
  useDocCommentAsDescription: true,
)
enum Vehicle {
  /// car description
  car,

  /// plane description
  plane,

  /// train description
  train,
}
