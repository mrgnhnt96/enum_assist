import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'maybe_example.ge.dart';

//! [MapExample]
// It is not required to annotate each field with
// MapExample(), the default value will be used

// NumberExt needs to be annotated on at least 1 field
class NumberExt extends MaybeExtension<int> {
  const NumberExt(int value)
      : super(
          value,
          methodName: 'number',
          defaultValue: 0,
        );
}

// Even though [allowNull] = true, [defaultValue] will be used as the default value
//
// IsImportant needs to be annotated on at least 1 field
class IsImportant extends MaybeExtension<bool?> {
  const IsImportant([bool? value])
      : super(
          value,
          methodName: 'is important',
          defaultValue: false,
          allowNulls: true,
        );
}

// Even though [allowNull] = true, [defaultValue] will be used as the default value
//
// IsImportant needs to be annotated on at least 1 field
class IsSmall extends MaybeExtension<bool?> {
  const IsSmall([bool? value])
      : super(
          value,
          methodName: 'isSmall',
          defaultValue: false,
          allowNulls: false,
        );
}

// FactorsExt needs to be annotated on at least 1 field
class FactorsExt extends MaybeExtension<List<int>> {
  const FactorsExt([List<int> value = const []])
      : super(
          value,
          methodName: 'factors',
          defaultValue: const [1, 2, 3],
        );
}

@EnumAssist()
enum Example {
  @EnumValue(extensions: [
    NumberExt(1),
    FactorsExt([1, 3]),
    IsImportant(true),
    IsSmall(true),
  ])
  one,

  @EnumValue(extensions: [])
  two,

  @EnumValue(extensions: [])
  three,
}

void main() {
  // TODO: update tests to reflect the added type to extensions
  // add tests when type is nullable & allowNulls if false
  // add tests when value is `__unassigned__`
  print(Example.three.isSmall);
}
