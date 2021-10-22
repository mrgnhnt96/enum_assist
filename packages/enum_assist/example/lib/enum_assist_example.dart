import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'enum_assist_example.ge.dart';

//! generates the following methods by default:
// - map
//    - is the equivalent to pattern matching
//
// - maybeMap
//    - is the equivalent to pattern matching,
//        but doesn't require all callbacks to be specified
//
// - name
//    - returns the name of the enum value
//    - Formats the field to capital case unless overriden with @EnumKey.name
//
// - description
//    - returns the description of the enum value
//    - Uses the doc comment of the field unless overriden with @EnumKey.description
//        or @EnumAssist.useDocCommentAsDescription is set to false
//        (in the annotation or build.yaml file)
//    - Uses the @EnumKey.description if overriden in annotation
//
// - serialized
//    - returns the serialized value of the enum value, the default
//        format is the name of the enum value
//    - Uses the @EnumKey.serialized if overriden in annotation
//    - Can be formatted via @EnumAssist.serializedFormat
//        (in annotation or build.yaml file)
//
// -----------
//
// generates the following classes by default:
// - ExampleConv
//    - Uses json_serializable `JsonConverter` to convert to and from json
//    - Can be used to annotate fields in model classes
//        e.g. @ExampleConv()
//
// - _ExampleNullableConv
//    - Uses json_serializable `JsonConverter` to convert to and from json
//        with nullable values
//    - Can be used to annotate fields in model classes
//        e.g. @ExampleConv.nullable

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
    useDocCommentAsDescription: false, // overriden
  )
  // two description
  two,

  @EnumKey(
    name: 'Threeeeee', // overriden
    description: 'three is the best', // overriden
    extensions: [], // default
    serializedValue: '3', // overriden
    useDocCommentAsDescription: false, // overriden
  )

  /// three description
  three,
}
