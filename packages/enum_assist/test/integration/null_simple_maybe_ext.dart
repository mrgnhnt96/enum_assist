import 'package:enum_assist_annotation/enum_assist_annotation.dart';

import 'util/far_ext.dart';

part 'null_simple_maybe_ext.ge.dart';

class NullNumExt extends MaybeExtension<int?> {
  const NullNumExt([int? value = 12])
      : super(
          value,
          defaultValue: 10,
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
  @EnumKey(extensions: [NullFarMaybeExt()])
  body,
  @EnumKey(extensions: [NullFarMaybeExt(3.01)])
  leg,
}

class NullDurationExt extends MaybeExtension<Duration?> {
  const NullDurationExt({Duration? value = const Duration(days: 5)})
      : super(value,
            methodName: 'Duration',
            allowNulls: true,
            defaultValue: const Duration(days: 1));
}

@EnumAssist()
enum Family {
  @EnumKey(extensions: [NullDurationExt()])
  mom,
  @EnumKey(extensions: [])
  dad,
  @EnumKey(extensions: [NullDurationExt(value: null)])
  kid,
}
