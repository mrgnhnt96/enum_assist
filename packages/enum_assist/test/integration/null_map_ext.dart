import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'null_map_ext.ge.dart';

class ListIntExt extends MapExtension<List<int>?> {
  const ListIntExt([List<int>? value = const [20]])
      : super(
          value,
          methodName: 'list int',
          allowNulls: true,
        );
}

class MapIntExt extends MapExtension<Map<String, int>?> {
  const MapIntExt([Map<String, int>? value = const {'': 20}])
      : super(
          value,
          methodName: 'map int',
          allowNulls: true,
        );
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [
    ListIntExt(),
    MapIntExt(),
  ])
  dog,
  @EnumKey(extensions: [
    ListIntExt(null),
    MapIntExt(null),
  ])
  cat,
  @EnumKey(extensions: [
    ListIntExt([400, 500, 600]),
    MapIntExt({'a': 400, 'b': 500, 'c': 600}),
  ])
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

class TranslationExt extends MapExtension<Translation?> {
  const TranslationExt(Translation? value)
      : super(
          value,
          methodName: 'translation',
          allowNulls: true,
        );
}

class ApodoExt extends MapExtension<List<Apodo>?> {
  const ApodoExt(List<Apodo>? value)
      : super(
          value,
          methodName: 'apodo',
          allowNulls: true,
        );
}

@EnumAssist()
enum Familia {
  @EnumKey(extensions: [
    TranslationExt(Translation('mom')),
    ApodoExt([Apodo('la jefa'), Apodo('some cool name')]),
  ])
  madre,
  @EnumKey(extensions: [
    TranslationExt(null),
    ApodoExt([]),
  ])
  padre,
  @EnumKey(extensions: [
    TranslationExt(Translation('son')),
    ApodoExt(null),
  ])
  hijo,
}

class BoolExt extends MapExtension<bool> {
  const BoolExt()
      : super(
          true,
          methodName: 'boolExt',
          allowNulls: true,
        );
}

class IntExt extends MapExtension<int> {
  const IntExt()
      : super(
          1,
          methodName: 'intExt',
          allowNulls: true,
        );
}

class DoubleExt extends MapExtension<double> {
  const DoubleExt()
      : super(
          .5,
          methodName: 'doubleExt',
          allowNulls: true,
        );
}

class StringExt extends MapExtension<String> {
  const StringExt()
      : super(
          'value',
          methodName: 'stringExt',
          allowNulls: true,
        );
}

class EnumExt extends MapExtension<Animal> {
  const EnumExt()
      : super(
          Animal.cat,
          methodName: 'enumExt',
          allowNulls: true,
        );
}

class ListExt extends MapExtension<List<int>> {
  const ListExt()
      : super(
          const [1, 2, 3],
          methodName: 'listExt',
          allowNulls: true,
        );
}

class MapExt extends MapExtension<Map<String, int>> {
  const MapExt()
      : super(
          const {'a': 1, 'b': 2, 'c': 3},
          methodName: 'mapExt',
          allowNulls: true,
        );
}

@EnumAssist()
enum Superhero {
  @EnumKey(extensions: [
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
