import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'enum_assist_example.ge.dart';

@EnumAssist(
  createJsonConv: true, // default
  serializedFormat: SerializedFormat.none, // default
  useDocCommentAsDescription: true, // default
)
enum Example {
  @EnumKey(
    name: 'One', // default
    description: 'one description', // default (uses doc comment)
    extensions: [], // default
    serializedValue: 'one', // default
    useDocCommentAsDescription: true, // default
  )

  /// one description
  one,

  @EnumKey(
    name: 'Two', // default
    description:
        null, // default (uses nothing because [useDocCommentAsDescription] is false)
    extensions: [], // default
    serializedValue: 'two', // default
    useDocCommentAsDescription: false, // overridden
  )
  // two description
  two,

  @EnumKey(
    name: 'Threeeeee', // overridden
    description: 'three is the best', // overridden
    extensions: [], // default
    serializedValue: '3', // overridden
    useDocCommentAsDescription: false, // overridden
  )

  /// three description
  three,
}
