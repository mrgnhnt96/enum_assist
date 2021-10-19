import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

import 'util/double_extension.dart';

part 'map_extension.ge.dart';

class NumExtension extends MapExtension<int> {
  const NumExtension(int value) : super(value, methodName: 'Num Extension');
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [NumExtension(100)])
  dog,
  @EnumKey(extensions: [NumExtension(200)])
  cat,
  @EnumKey(extensions: [NumExtension(300)])
  mouse,
}

class NullNumExtension extends MapExtension<int?> {
  const NullNumExtension([int? value])
      : super(
          value,
          methodName: 'NullNum Extension',
          allowNulls: true,
        );
}

@EnumAssist()
enum Letters {
  /// handWritten doc comment
  @EnumKey(extensions: [NullNumExtension()])
  handWritten,

  /// email doc comment
  @EnumKey(extensions: [NullNumExtension(200)])
  email,

  /// hate doc comment
  @EnumKey(extensions: [NullNumExtension()])
  hate,
}

@EnumAssist()
enum BodyParts {
  @EnumKey(extensions: [DoubleExtension(1.01)])
  head,
  @EnumKey(extensions: [DoubleExtension(2.01)])
  body,
  @EnumKey(extensions: [DoubleExtension(3.01)])
  leg,
}

class DurationExtension extends MapExtension<Duration> {
  const DurationExtension(Duration value)
      : super(value, methodName: 'Duration Extension');
}

@EnumAssist()
enum Family {
  @EnumKey(extensions: [DurationExtension(Duration(days: 1))])
  mom,
  @EnumKey(extensions: [DurationExtension(Duration(days: 2))])
  dad,
  @EnumKey(extensions: [DurationExtension(Duration(days: 3))])
  kid,
}

@immutable
class MyClass {
  const MyClass(this.name);

  final String name;

  ///
  @override
  // ignore: hash_and_equals
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MyClass &&
            runtimeType == other.runtimeType &&
            name == other.name);
  }
}

class MyClassValue extends MapExtension<MyClass> {
  const MyClassValue(MyClass value)
      : super(value, methodName: 'MyClass Extension');
}

@EnumAssist()
enum Familia {
  @EnumKey(extensions: [MyClassValue(MyClass('mama'))])
  madre,
  @EnumKey(extensions: [MyClassValue(MyClass('papa'))])
  padre,
  @EnumKey(extensions: [MyClassValue(MyClass('mijo'))])
  hijo,
}
