import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'map_extension.ge.dart';

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
  @EnumValue()
  handWritten,

  /// email doc comment
  @EnumValue(extensions: [NullNumExtension(200)])
  email,

  /// hate doc comment
  @EnumValue(extensions: [NullNumExtension()])
  hate,
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
  @EnumValue(extensions: [MyClassValue(MyClass('mama'))])
  madre,
  @EnumValue(extensions: [MyClassValue(MyClass('papa'))])
  padre,
  @EnumValue(extensions: [MyClassValue(MyClass('mijo'))])
  hijo,
}
