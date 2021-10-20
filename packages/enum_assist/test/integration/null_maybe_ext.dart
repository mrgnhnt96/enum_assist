import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

part 'null_maybe_ext.ge.dart';

class ListExt extends MaybeExtension<List<int>?> {
  const ListExt([List<int>? value = const [20]])
      : super(
          value,
          methodName: 'list',
          allowNulls: true,
          defaultValue: const [10],
        );
}

class MaybeExt extends MaybeExtension<Map<String, int>?> {
  const MaybeExt([Map<String, int>? value = const {'': 20}])
      : super(
          value,
          methodName: 'mapExt',
          allowNulls: true,
          defaultValue: const {'': 10},
        );
}

@EnumAssist()
enum Animal {
  @EnumKey(extensions: [
    ListExt(),
    MaybeExt(),
  ])
  dog,
  @EnumKey(extensions: [
    ListExt(null),
    MaybeExt(null),
  ])
  cat,
  @EnumKey(extensions: [])
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
  @EnumKey(extensions: [
    TranslationExt(Translation('mom')),
    ApodoExt([Apodo('la jefa'), Apodo('some cool name')]),
  ])
  madre,
  @EnumKey(extensions: [
    TranslationExt(null),
    ApodoExt(null),
  ])
  padre,
  @EnumKey(extensions: [])
  hijo,
}
