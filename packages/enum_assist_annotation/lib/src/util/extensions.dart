import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// Extensions for [FieldFormat]
extension FieldFormatX on FieldFormat {
  /// maps all values
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

  /// maps values with default value [orElse]
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
