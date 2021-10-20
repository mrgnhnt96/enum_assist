import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'null_map_ext.ge.dart';

class ListExt extends MapExtension<List<int>?> {
  const ListExt([List<int>? value = const [20]])
      : super(
          value,
          methodName: 'list',
          allowNulls: true,
        );
}

class MapExt extends MapExtension<Map<String, int>?> {
  const MapExt([Map<String, int>? value = const {'': 20}])
      : super(
          value,
          methodName: 'mapExt',
          allowNulls: true,
        );
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [
    ListExt(),
    MapExt(),
  ])
  dog,
  @EnumKey(extensions: [
    ListExt(null),
    MapExt(null),
  ])
  cat,
  @EnumKey(extensions: [
    ListExt([400, 500, 600]),
    MapExt({'a': 400, 'b': 500, 'c': 600}),
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
