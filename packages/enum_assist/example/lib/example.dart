import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

@EnumAssist(
  serializedFormat: SerializedFormat.none, // default
  createJsonConv: true, // default
  useDocCommentAsDescription: true, // default
)
enum Numbers {
  /// this is the number 11
  ///
  /// just so you know
  @EnumKey(
    extensions: [
      CoolExt('sup'),
      ToNumExt(value: 11),
    ],
  )
  eleven,

  @EnumKey(extensions: [
    CoolExt('hi'),
    ToNumExt(value: 22),
  ])
  twentyTwo,

  @EnumKey(
    name: 'threeThree',
    serializedValue: '1',
    extensions: [
      ToNumExt(value: 33),
      OtherExt(),
    ],
  )
  thirtyThree,
}

class CoolExt extends MaybeExtension<String> {
  const CoolExt(String value)
      : super(
          value,
          methodName: 'coolio', // required
          defaultValue: 'lol', // required
          allowNulls: false, // default value
          docComment: 'this is a cool extension!', // optional
        );
}

class ToNumExt extends MapExtension<int?> {
  const ToNumExt({int? value})
      : super(
          value,
          methodName: 'toNum', // required
          allowNulls: false, // default value
          docComment: 'this is a doc comment', // optional
        );
}

class OtherExt extends MapExtension<int> {
  const OtherExt({int value = 10})
      : super(
          value,
          methodName: 'other', // required
          allowNulls: true,
          docComment: 'this is a doc comment', // optional
        );
}
