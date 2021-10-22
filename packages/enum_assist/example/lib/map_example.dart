import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'map_example.ge.dart';

//! [MapExample]
// Unless `MapExample.allowNull` is set to true,
// each field must be annotated with MapExample()

// NumberExt is required to be included in `extensions`
// for all fields
class NumberExt extends MapExtension<int> {
  const NumberExt(int value) : super(value, methodName: 'number');
}

// because [allowNull] = true, null will be used as the default value
// IsImportant needs to be annotated on at least 1 field
class IsImportant extends MapExtension<bool?> {
  const IsImportant([bool? value])
      : super(
          value,
          methodName: 'is important',
          allowNulls: true,
        );
}

// FactorsExt is required to be included in `extensions`
// for all fields
//
// const [] will be used as the default value
class FactorsExt extends MapExtension<List<int>> {
  const FactorsExt([List<int> value = const []])
      : super(
          value,
          methodName: 'factors',
        );
}

@EnumAssist()
enum Example {
  @EnumKey(extensions: [
    NumberExt(1),
    FactorsExt([1, 3]),
    IsImportant(true),
  ])
  one,

  @EnumKey(extensions: [NumberExt(2), FactorsExt()])
  two,

  @EnumKey(extensions: [
    NumberExt(3),
    FactorsExt([1, 3]),
  ])
  three,
}
