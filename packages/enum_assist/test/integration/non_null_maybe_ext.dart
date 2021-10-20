import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'non_null_maybe_ext.ge.dart';

class ListExt extends MaybeExtension<List<int>> {
  const ListExt([List<int> value = const [20]])
      : super(
          value,
          methodName: 'list',
          defaultValue: const [10],
        );
}

class MapExt extends MaybeExtension<Map<String, int>> {
  const MapExt([Map<String, int> value = const {'': 20}])
      : super(
          value,
          methodName: 'mapExt',
          defaultValue: const {'': 10},
        );
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [])
  dog,
  @EnumKey(extensions: [
    ListExt(),
    MapExt(),
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
