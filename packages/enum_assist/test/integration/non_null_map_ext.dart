import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'non_null_map_ext.ge.dart';

class ListIntExt extends MapExtension<List<int>> {
  const ListIntExt([List<int> value = const [20]])
      : super(value, methodName: 'list');
}

class MapIntExt extends MapExtension<Map<String, int>> {
  const MapIntExt([Map<String, int> value = const {'': 20}])
      : super(value, methodName: 'mapInt');
}

@EnumAssist()
enum Animal {
  @EnumValue(extensions: [
    ListIntExt(),
    MapIntExt(),
  ])
  dog,
  @EnumValue(extensions: [
    ListIntExt([100, 200, 300]),
    MapIntExt({'a': 100, 'b': 200, 'c': 300}),
  ])
  cat,
  @EnumValue(extensions: [
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

class TranslationExt extends MapExtension<Translation> {
  const TranslationExt(Translation value)
      : super(value, methodName: 'translation');
}

class ApodoExt extends MapExtension<List<Apodo>> {
  const ApodoExt(List<Apodo> value) : super(value, methodName: 'apodo');
}

@EnumAssist()
enum Familia {
  @EnumValue(extensions: [
    TranslationExt(Translation('mom')),
    ApodoExt([Apodo('la jefa'), Apodo('some cool name')]),
  ])
  madre,
  @EnumValue(extensions: [
    TranslationExt(Translation('dad')),
    ApodoExt([Apodo('peluche'), Apodo('some cool name')]),
  ])
  padre,
  @EnumValue(extensions: [
    TranslationExt(Translation('son')),
    ApodoExt([Apodo('moco'), Apodo('[{some cool{, } name}]')]),
  ])
  hijo,
}

class BoolExt extends MapExtension<bool> {
  const BoolExt() : super(true, methodName: 'boolExt');
}

class IntExt extends MapExtension<int> {
  const IntExt() : super(1, methodName: 'intExt');
}

class DoubleExt extends MapExtension<double> {
  const DoubleExt() : super(.5, methodName: 'doubleExt');
}

class StringExt extends MapExtension<String> {
  const StringExt() : super('value', methodName: 'stringExt');
}

class EnumExt extends MapExtension<Animal> {
  const EnumExt() : super(Animal.cat, methodName: 'enumExt');
}

class ListExt extends MapExtension<List<int>> {
  const ListExt() : super(const [1, 2, 3], methodName: 'listExt');
}

class MapExt extends MapExtension<Map<String, int>> {
  const MapExt() : super(const {'a': 1, 'b': 2, 'c': 3}, methodName: 'mapExt');
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
