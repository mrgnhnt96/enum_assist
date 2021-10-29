import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import '../util/far_ext.dart';

part 'null_simple_map_ext.ge.dart';

class NullNumExt extends MapExtension<int?> {
  const NullNumExt([int? value = 12])
      : super(
          value,
          methodName: 'small num',
          allowNulls: true,
        );
}

@EnumAssist()
enum Animal {
  @EnumValue()
  dog,
  @EnumValue(extensions: [])
  cat,
  @EnumValue(extensions: [NullNumExt(null)])
  mouse,
}

@EnumAssist()
enum BodyParts {
  @EnumValue()
  head,
  @EnumValue(extensions: [NullFarMapExt()])
  body,
  @EnumValue(extensions: [NullFarMapExt(3.01)])
  leg,
}

class NullDurationExt extends MapExtension<Duration?> {
  const NullDurationExt({Duration? value = const Duration(days: 1)})
      : super(
          value,
          methodName: 'Duration',
          allowNulls: true,
        );
}

@EnumAssist()
enum Family {
  @EnumValue(extensions: [NullDurationExt()])
  mom,
  @EnumValue(extensions: [NullDurationExt(value: Duration(days: 2))])
  dad,
  @EnumValue(extensions: [NullDurationExt(value: null)])
  kid,
}
