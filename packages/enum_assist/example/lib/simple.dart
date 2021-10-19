import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'simple.ge.dart';

@EnumAssist(
  createJsonConv: true,
)
enum SimpleEnum {
  @EnumKey(
    description: 'description',
    name: 'name',
    serializedValue: 'value',
    extensions: [
      MyOtherValue(Duration(days: 1)),
      MyValue2(value: Duration(days: 1)),
    ],
  )
  one,
  @EnumKey(
    extensions: [
      MyValue2(value: Duration(days: 1)),
      MyOtherValue(Duration(days: 1)),
    ],
  )
  two,
  @EnumKey(
    extensions: [
      MyOtherValue(Duration(days: 1)),
    ],
  )
  three,
}

class MyOtherValue extends MyValue {
  const MyOtherValue(Duration value) : super(value);
}

class MyValue extends MapExtension<Duration> {
  const MyValue(Duration value)
      : super(
          value,
          methodName: 'MyCoolMethod',
          allowNulls: false,
        );
}

class MyValue2 extends MaybeExtension<Duration?> {
  const MyValue2({Duration? value})
      : super(
          value,
          methodName: 'MyCoolMethod2',
          allowNulls: true,
          defaultValue: const Duration(days: 1),
        );
}
