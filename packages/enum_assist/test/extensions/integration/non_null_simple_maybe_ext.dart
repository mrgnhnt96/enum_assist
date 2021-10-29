import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import '../util/far_ext.dart';

part 'non_null_simple_maybe_ext.ge.dart';

class NumExt extends MaybeExtension<int> {
  const NumExt([int value = 20])
      : super(
          value,
          methodName: 'small num',
          defaultValue: 10,
        );
}

@EnumAssist()
enum Animal {
  @EnumValue(extensions: [])
  dog,
  @EnumValue(extensions: [NumExt()])
  cat,
  @EnumValue(extensions: [NumExt(300)])
  mouse,
}

@EnumAssist()
enum BodyParts {
  @EnumValue()
  head,
  @EnumValue(extensions: [FarMaybeExt(2.01)])
  body,
  @EnumValue(extensions: [FarMaybeExt(3.01)])
  leg,
}

class DurationExt extends MaybeExtension<Duration> {
  const DurationExt({Duration value = const Duration(days: 1)})
      : super(
          value,
          methodName: 'Duration',
          defaultValue: const Duration(days: 10),
        );
}

@EnumAssist()
enum Family {
  @EnumValue(extensions: [DurationExt()])
  mom,
  @EnumValue(extensions: [])
  dad,
  @EnumValue(extensions: [DurationExt(value: Duration(days: 3))])
  kid,
}
