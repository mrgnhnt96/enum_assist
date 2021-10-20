import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import 'util/far_ext.dart';

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
  @EnumKey()
  dog,
  @EnumKey(extensions: [])
  cat,
  @EnumKey(extensions: [NullNumExt(null)])
  mouse,
}

@EnumAssist()
enum BodyParts {
  @EnumKey()
  head,
  @EnumKey(extensions: [NullFarMapExt()])
  body,
  @EnumKey(extensions: [NullFarMapExt(3.01)])
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
  @EnumKey(extensions: [NullDurationExt()])
  mom,
  @EnumKey(extensions: [NullDurationExt(value: Duration(days: 2))])
  dad,
  @EnumKey(extensions: [NullDurationExt(value: null)])
  kid,
}
