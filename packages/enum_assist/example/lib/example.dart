import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

@EnumAssist(
  serializedFormat: SerializedFormat.snake,
)
enum Numbers {
  /// this is a fake 11
  @EnumKey(extensions: [
    MyExtension('11'),
    OtherExtension(value: 12),
  ])
  onetyOne,

  /// this is a fake 22
  @EnumKey(extensions: [
    MyExtension('22'),
  ])
  twothyTwo,

  /// this is a fake 33
  ///
  ///
  ///
  /// and probably something else
  @EnumKey(
    name: 'threeThree',
    serializedValue: '1',
    extensions: [
      MyExtension('33'),
    ],
  )
  threelyThree,
}

class MyExtension extends MapExtension<String> {
  const MyExtension(String value) : super(value, methodName: 'myCoolMethod');
}

class OtherExtension extends MapExtension<int?> {
  const OtherExtension({int? value})
      : super(value, methodName: 'nullableMethod', allowNulls: true);
}
