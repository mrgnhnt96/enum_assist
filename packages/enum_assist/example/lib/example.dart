import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

@EnumAssist(
  fieldFormat: FieldFormat.snake,
  additionalExtensions: [MyExtension()],
)
enum Numbers {
  /// this is a fake 11
  @EnumKey(extensionValues: [
    MyExtensionValue('11'),
  ])
  onetyOne,

  /// this is a fake 22
  @EnumKey(extensionValues: [
    MyExtensionValue('22'),
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
    extensionValues: [
      MyExtensionValue('33'),
    ],
  )
  threelyThree,
}

class MyExtension extends MapExtension<String, MyExtensionValue> {
  const MyExtension() : super('myCoolMethod');
}

class MyExtensionValue extends ExtensionValue<String> {
  const MyExtensionValue(value) : super(value);
}
