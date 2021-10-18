import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'simple.ge.dart';

@EnumAssist(
  createJsonConv: true,
  additionalExtensions: [
    MyOtherExtension(),
    MyExtension2(),
  ],
)
enum SimpleEnum {
  @EnumKey(
    description: 'description',
    name: 'name',
    serializedValue: 'value',
    extensionValues: [
      MyOtherValue(Duration(days: 1)),
      MyValue2(Duration(days: 1)),
    ],
  )
  one,
  @EnumKey(
    extensionValues: [
      MyValue2(Duration(days: 1)),
    ],
  )
  two,
  @EnumKey(
    extensionValues: [
      MyValue2(Duration(days: 1)),
    ],
  )
  three,
}

class MyOtherExtension extends MyExtension {
  const MyOtherExtension();
}

class MyOtherValue extends MyValue {
  const MyOtherValue(Duration value) : super(value);
}

class MyExtension extends MaybeMapExtension<Duration?, MyValue> {
  const MyExtension()
      : super(
          'MyCoolMethod',
          defaultValue: const Duration(days: 1),
          allowNulls: true,
        );
}

class MyExtension2 extends MaybeMapExtension<Duration, MyValue2> {
  const MyExtension2()
      : super('MyCoolMethod2', defaultValue: const Duration(days: 1));
}

class MyValue extends ExtensionValue<Duration> {
  const MyValue(Duration value) : super('MyCoolMethod', value);
}

class MyValue2 extends ExtensionValue<Duration> {
  const MyValue2(Duration value) : super('MyCoolMethod2', value);
}
