import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import '../util/far_ext.dart';

part 'non_null_simple_map_ext.ge.dart';

class NumExt extends MapExtension<int> {
  const NumExt([int value = 20]) : super(value, methodName: 'small num');
}

@EnumAssist()
enum Animal {
  @EnumValue(extensions: [NumExt()])
  dog,
  @EnumValue(extensions: [NumExt(200)])
  cat,
  @EnumValue(extensions: [NumExt(300)])
  mouse,
}

@EnumAssist()
enum BodyParts {
  @EnumValue(extensions: [FarMapExt(1.01)])
  head,
  @EnumValue(extensions: [FarMapExt(2.01)])
  body,
  @EnumValue(extensions: [FarMapExt(3.01)])
  leg,
}

class DurationExt extends MapExtension<Duration> {
  const DurationExt({Duration value = const Duration(days: 1)})
      : super(value, methodName: 'Duration');
}

@EnumAssist()
enum Family {
  @EnumValue(extensions: [DurationExt()])
  mom,
  @EnumValue(extensions: [DurationExt(value: Duration(days: 2))])
  dad,
  @EnumValue(extensions: [DurationExt(value: Duration(days: 3))])
  kid,
}
