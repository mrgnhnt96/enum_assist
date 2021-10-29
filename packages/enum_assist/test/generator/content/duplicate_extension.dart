import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class MyExt extends MaybeExtension<int> {
  const MyExt(int value)
      : super(
          value,
          defaultValue: 0,
          methodName: 'methodName',
        );
}

@EnumAssist()
enum TestEnum {
  @EnumValue(extensions: [
    MyExt(1),
    MyExt(1),
  ])
  value1,
  @EnumValue()
  value2,
  @EnumValue()
  value3,
}
