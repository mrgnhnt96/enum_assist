import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist_annotation.extension}
/// Extensions for [FieldFormat]
/// {@endtemplate}
extension FieldFormatX on FieldFormat {
  /// {@template enum_assist_annotation.extension.map}
  /// maps all values
  /// {@endtemplate}
  T map<T>({
    required T kebab,
    required T snake,
    required T pascal,
    required T none,
  }) {
    switch (this) {
      case FieldFormat.kebab:
        return kebab;
      case FieldFormat.snake:
        return snake;
      case FieldFormat.pascal:
        return pascal;
      case FieldFormat.none:
        return none;
    }
  }

  /// {@template enum_assist_annotation.extension.maybe_map}
  /// maps values with default value [orElse]
  /// {@endtemplate}
  T maybeMap<T>({
    T? kebab,
    T? snake,
    T? pascal,
    T? none,
    required T orElse,
  }) {
    switch (this) {
      case FieldFormat.kebab:
        if (kebab == null) return orElse;
        return kebab;
      case FieldFormat.snake:
        if (snake == null) return orElse;
        return snake;
      case FieldFormat.pascal:
        if (pascal == null) return orElse;
        return pascal;
      case FieldFormat.none:
        if (none == null) return orElse;
        return none;
    }
  }
}

/// {@macro enum_assist_annotation.extension}
extension MethodTypeX on MethodType {
  /// {@macro enum_assist_annotation.extension.map}
  T map<T>({
    required T maybeMapMethod,
    required T mapMethod,
  }) {
    switch (this) {
      case MethodType.maybeMap:
        return maybeMapMethod;
      case MethodType.map:
        return mapMethod;
    }
  }

  /// {@macro enum_assist_annotation.extension.maybe_map}
  T maybeMap<T>({
    T? maybeMapMethod,
    T? mapMethod,
    required T orElse,
  }) {
    switch (this) {
      case MethodType.maybeMap:
        if (maybeMapMethod == null) return orElse;
        return maybeMapMethod;
      case MethodType.map:
        if (mapMethod == null) return orElse;
        return mapMethod;
    }
  }
}
