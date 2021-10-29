import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class MyExt extends MapExtension<int> {
  const MyExt(int value)
      : super(
          value,
          methodName: 'methodName',
        );
}

@EnumAssist()
enum TestEnum {
  @EnumValue(extensions: [
    MyExt(2),
  ])
  value1,
  @EnumValue()
  value2,
  @EnumValue(extensions: [
    MyExt(1),
  ])
  value3,
}
