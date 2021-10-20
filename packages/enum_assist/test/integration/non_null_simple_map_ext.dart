import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import 'util/far_ext.dart';

part 'non_null_simple_map_ext.ge.dart';

class NumExt extends MapExtension<int> {
  const NumExt([int value = 20]) : super(value, methodName: 'small num');
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [NumExt()])
  dog,
  @EnumKey(extensions: [NumExt(200)])
  cat,
  @EnumKey(extensions: [NumExt(300)])
  mouse,
}

@EnumAssist()
enum BodyParts {
  @EnumKey(extensions: [FarMapExt(1.01)])
  head,
  @EnumKey(extensions: [FarMapExt(2.01)])
  body,
  @EnumKey(extensions: [FarMapExt(3.01)])
  leg,
}

class DurationExt extends MapExtension<Duration> {
  const DurationExt({Duration value = const Duration(days: 1)})
      : super(value, methodName: 'Duration');
}

@EnumAssist()
enum Family {
  @EnumKey(extensions: [DurationExt()])
  mom,
  @EnumKey(extensions: [DurationExt(value: Duration(days: 2))])
  dad,
  @EnumKey(extensions: [DurationExt(value: Duration(days: 3))])
  kid,
}
