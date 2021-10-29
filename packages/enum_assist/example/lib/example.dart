import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

class IsPrime extends MaybeExtension<bool> {
  const IsPrime(bool value)
      : super(
          value,
          methodName: 'is prime', // required
          defaultValue: false, // required
          allowNulls: false, // default value
          docComment: 'whether the value is prime', // optional
        );
}

class ToMap extends MapExtension<Map<String, int>> {
  const ToMap(Map<String, int> value)
      : super(
          value,
          methodName: 'toMap', // required
          allowNulls: false, // default value
          docComment: 'converts value to a map', // optional
        );
}

@EnumAssist(
  serializedFormat: SerializedFormat.none, // default
  createJsonConv: true, // default
  useDocCommentAsDescription: true, // default
)
enum Numbers {
  /// this is the number 11
  ///
  /// and its prime!
  @EnumValue(
    description: '11 is also a girl from Stranger Things', // optional
    readable: 'Eleven', // default (field name formatted to Capital Case)
    serializedValue: 'eleven', // default (field name formatted as is)
    useDocCommentAsDescription: true, // default
    extensions: [
      ToMap({'eleven': 11}),
      IsPrime(true)
    ],
  )
  eleven,

  @EnumValue(
    extensions: [
      ToMap({'twenty-two': 22})
    ],
  )
  twentyTwo,

  @EnumValue(
    extensions: [
      ToMap({'thirty-three': 33}),
    ],
  )
  thirtyThree,
}
