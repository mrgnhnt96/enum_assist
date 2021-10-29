import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'doc_comments.ge.dart';

@EnumAssist()
enum Animal {
  /// dog doc comment
  dog,

  /// cat doc comment
  cat,

  /// mouse doc comment
  mouse,
}

@EnumAssist(
  useDocCommentAsDescription: false,
)
enum Letters {
  /// handWritten doc comment
  handWritten,

  /// email doc comment
  email,

  /// hate doc comment
  hate,
}

@EnumAssist()
enum Vehicle {
  /// car doc comment
  car,

  /// plane doc comment
  @EnumValue(
    useDocCommentAsDescription: false,
  )
  plane,

  /// train doc comment
  train,
}

@EnumAssist()
enum BodyParts {
  /// head doc comment
  head,

  /// arm doc comment
  @EnumValue(description: 'My arms look tiny')
  arm,

  /// leg doc comment
  leg,
}
