import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'null_maybe_ext.ge.dart';

class ListInt extends MaybeExtension<List<int>?> {
  const ListInt([List<int>? value = const [20]])
      : super(
          value,
          methodName: 'list int',
          allowNulls: true,
          defaultValue: const [10],
        );
}

class MapInt extends MaybeExtension<Map<String, int>?> {
  const MapInt([Map<String, int>? value = const {'': 20}])
      : super(
          value,
          methodName: 'map int',
          allowNulls: true,
          defaultValue: const {'': 10},
        );
}

@EnumAssist()
enum Animal {
  @EnumValue(extensions: [
    ListInt(),
    MapInt(),
  ])
  dog,
  @EnumValue(extensions: [
    ListInt(null),
    MapInt(null),
  ])
  cat,
  @EnumValue(extensions: [])
  mouse,
}

@immutable
class Translation {
  const Translation(this.name);

  final String name;

  ///
  @override
  // ignore: hash_and_equals
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Translation &&
            runtimeType == other.runtimeType &&
            name == other.name);
  }
}

@immutable
class Apodo {
  const Apodo(this.name);

  final String name;

  ///
  @override
  // ignore: hash_and_equals
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Apodo &&
            runtimeType == other.runtimeType &&
            name == other.name);
  }
}

class TranslationExt extends MaybeExtension<Translation?> {
  const TranslationExt(Translation? value)
      : super(
          value,
          methodName: 'translation',
          allowNulls: true,
          defaultValue: const Translation('default'),
        );
}

class ApodoExt extends MaybeExtension<List<Apodo>?> {
  const ApodoExt(List<Apodo>? value)
      : super(
          value,
          methodName: 'apodo',
          allowNulls: true,
          defaultValue: const [Apodo('default')],
        );
}

@EnumAssist()
enum Familia {
  @EnumValue(extensions: [
    TranslationExt(Translation('mom')),
    ApodoExt([Apodo('la jefa'), Apodo('some cool name')]),
  ])
  madre,
  @EnumValue(extensions: [
    TranslationExt(null),
    ApodoExt(null),
  ])
  padre,
  @EnumValue(extensions: [])
  hijo,
}

class BoolExt extends MaybeExtension<bool> {
  const BoolExt()
      : super(
          true,
          methodName: 'boolExt',
          defaultValue: true,
          allowNulls: true,
        );
}

class IntExt extends MaybeExtension<int> {
  const IntExt()
      : super(
          1,
          methodName: 'intExt',
          defaultValue: 1,
          allowNulls: true,
        );
}

class DoubleExt extends MaybeExtension<double> {
  const DoubleExt()
      : super(
          .5,
          methodName: 'doubleExt',
          defaultValue: .5,
          allowNulls: true,
        );
}

class StringExt extends MaybeExtension<String> {
  const StringExt()
      : super(
          'value',
          methodName: 'stringExt',
          defaultValue: 'value',
          allowNulls: true,
        );
}

class EnumExt extends MaybeExtension<Animal> {
  const EnumExt()
      : super(
          Animal.cat,
          methodName: 'enumExt',
          defaultValue: Animal.cat,
          allowNulls: true,
        );
}

class ListExt extends MaybeExtension<List<int>> {
  const ListExt()
      : super(
          const [1, 2, 3],
          methodName: 'listExt',
          defaultValue: const [1, 2, 3],
          allowNulls: true,
        );
}

class MapExt extends MaybeExtension<Map<String, int>> {
  const MapExt()
      : super(
          const {'a': 1, 'b': 2, 'c': 3},
          methodName: 'mapExt',
          defaultValue: const {'a': 1, 'b': 2, 'c': 3},
          allowNulls: true,
        );
}

@EnumAssist()
enum Superhero {
  @EnumValue(extensions: [
    BoolExt(),
    IntExt(),
    DoubleExt(),
    StringExt(),
    EnumExt(),
    ListExt(),
    MapExt(),
  ])
  superman,
}
