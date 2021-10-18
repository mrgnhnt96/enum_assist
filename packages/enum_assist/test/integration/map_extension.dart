import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import 'util/double_extension.dart';

part 'map_extension.ge.dart';

class NumExtension extends MapExtension<int, NumValue> {
  const NumExtension() : super('Num Extension');
}

class NumValue extends ExtensionValue<int> {
  const NumValue(int value) : super('Num Extension', value);
}

@EnumAssist(
  additionalExtensions: [
    NumExtension(),
  ],
)
enum Animals {
  @EnumKey(extensionValues: [NumValue(100)])
  dog,
  @EnumKey(extensionValues: [NumValue(200)])
  cat,
  @EnumKey(extensionValues: [NumValue(300)])
  mouse,
}

class NullNumExtension extends MapExtension<int?, NullNumValue> {
  const NullNumExtension() : super('NullNum Extension');
}

class NullNumValue extends ExtensionValue<int?> {
  const NullNumValue([int? value]) : super('NullNum Extension', value);
}

@EnumAssist(
  additionalExtensions: [
    NullNumExtension(),
  ],
)
enum Letters {
  /// handWritten doc comment
  @EnumKey(extensionValues: [NullNumValue()])
  handWritten,

  /// email doc comment
  @EnumKey(extensionValues: [NullNumValue(200)])
  email,

  /// hate doc comment
  @EnumKey(extensionValues: [NullNumValue()])
  hate,
}

@EnumAssist(additionalExtensions: [
  DoubleExtension(),
])
enum BodyParts {
  @EnumKey(extensionValues: [DoubleValue(1.01)])
  head,
  @EnumKey(extensionValues: [DoubleValue(2.01)])
  body,
  @EnumKey(extensionValues: [DoubleValue(3.01)])
  leg,
}

class DurationExtension extends MapExtension<Duration, DurationValue> {
  const DurationExtension() : super('Duration Extension');
}

class DurationValue extends ExtensionValue<Duration> {
  const DurationValue(Duration value) : super('Duration Extension', value);
}

@EnumAssist(additionalExtensions: [
  DurationExtension(),
])
enum Family {
  @EnumKey(extensionValues: [DurationValue(Duration(days: 1))])
  mom,
  @EnumKey(extensionValues: [DurationValue(Duration(days: 2))])
  dad,
  @EnumKey(extensionValues: [DurationValue(Duration(days: 3))])
  kid,
}

class MyClass {
  const MyClass(this.name);

  final String name;
}

class MyClassExtension extends MapExtension<MyClass, MyClassValue> {
  const MyClassExtension() : super('MyClass Extension');
}

class MyClassValue extends ExtensionValue<MyClass> {
  const MyClassValue(MyClass value) : super('MyClass Extension', value);
}

@EnumAssist(additionalExtensions: [
  MyClassExtension(),
])
enum Familia {
  @EnumKey(extensionValues: [MyClassValue(MyClass('mama'))])
  madre,
  @EnumKey(extensionValues: [MyClassValue(MyClass('papa'))])
  padre,
  @EnumKey(extensionValues: [MyClassValue(MyClass('mijo'))])
  hijo,
}

// TODO: figure out how to use non literal values