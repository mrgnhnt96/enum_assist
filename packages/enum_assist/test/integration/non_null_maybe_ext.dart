import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'non_null_maybe_ext.ge.dart';

class ListIntExt extends MaybeExtension<List<int>> {
  const ListIntExt([List<int> value = const [20]])
      : super(
          value,
          methodName: 'list int',
          defaultValue: const [10],
        );
}

class MapIntExt extends MaybeExtension<Map<String, int>> {
  const MapIntExt([Map<String, int> value = const {'': 20}])
      : super(
          value,
          methodName: 'mapInt',
          defaultValue: const {'': 10},
        );
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [])
  dog,
  @EnumKey(extensions: [
    ListIntExt(),
    MapIntExt(),
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

class TranslationExt extends MaybeExtension<Translation> {
  const TranslationExt(Translation value)
      : super(
          value,
          methodName: 'translation',
          defaultValue: const Translation('default'),
        );
}

class ApodoExt extends MaybeExtension<List<Apodo>> {
  const ApodoExt(List<Apodo> value)
      : super(
          value,
          methodName: 'apodo',
          defaultValue: const [],
        );
}

@EnumAssist()
enum Familia {
  @EnumKey()
  madre,
  @EnumKey(extensions: [
    TranslationExt(Translation('dad')),
    ApodoExt([Apodo('peluche'), Apodo('some cool name')]),
  ])
  padre,
  @EnumKey(extensions: [
    TranslationExt(Translation('son')),
    ApodoExt([Apodo('moco'), Apodo('[{some cool{, } name}]')]),
  ])
  hijo,
}

class BoolExt extends MaybeExtension<bool> {
  const BoolExt()
      : super(
          true,
          methodName: 'boolExt',
          defaultValue: true,
        );
}

class IntExt extends MaybeExtension<int> {
  const IntExt()
      : super(
          1,
          methodName: 'intExt',
          defaultValue: 1,
        );
}

class DoubleExt extends MaybeExtension<double> {
  const DoubleExt()
      : super(
          .5,
          methodName: 'doubleExt',
          defaultValue: .5,
        );
}

class StringExt extends MaybeExtension<String> {
  const StringExt()
      : super(
          'value',
          methodName: 'stringExt',
          defaultValue: 'value',
        );
}

class EnumExt extends MaybeExtension<Animal> {
  const EnumExt()
      : super(
          Animal.cat,
          methodName: 'enumExt',
          defaultValue: Animal.cat,
        );
}

class ListExt extends MaybeExtension<List<int>> {
  const ListExt()
      : super(
          const [1, 2, 3],
          methodName: 'listExt',
          defaultValue: const [1, 2, 3],
        );
}

class MapExt extends MaybeExtension<Map<String, int>> {
  const MapExt()
      : super(
          const {'a': 1, 'b': 2, 'c': 3},
          methodName: 'mapExt',
          defaultValue: const {'a': 1, 'b': 2, 'c': 3},
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
