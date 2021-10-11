import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.field_set}
/// A helper class to provide data & methods for given field
/// {@endtemplate}
class FieldSet implements Comparable<FieldSet> {
  /// {@template enum_assist.field_set.name}
  factory FieldSet(FieldElement? classField, FieldElement? superField) {
    // At least one of these will != null, perhaps both.
    final fields = [classField, superField].whereType<FieldElement>().toList();

    // Prefer the class field over the inherited field when sorting.
    final sortField = fields.first;

    // Prefer the field that's annotated with `EnumKey`, if any.
    // If not, use the class field.
    final fieldHasEnumKey =
        fields.firstWhere(_hasEnumKeyAnnotation, orElse: () => fields.first);

    return FieldSet._(fieldHasEnumKey, sortField);
  }

  FieldSet._(this.field, this.sortField) : assert(field.name == sortField.name);

  /// The [field]
  final FieldElement field;

  /// The [sortField]
  final FieldElement sortField;

  @override
  int compareTo(FieldSet other) => _sortByLocation(sortField, other.sortField);

  static int _sortByLocation(FieldElement a, FieldElement b) {
    final checkerA =
        TypeChecker.fromStatic((a.enclosingElement as ClassElement).thisType);

    if (!checkerA.isExactly(b.enclosingElement)) {
      // in this case, you want to prioritize the enclosingElement that is more
      // "super".

      if (checkerA.isAssignableFrom(b.enclosingElement)) {
        return -1;
      }

      final checkerB =
          TypeChecker.fromStatic((b.enclosingElement as ClassElement).thisType);

      if (checkerB.isAssignableFrom(a.enclosingElement)) {
        return 1;
      }
    }

    /// Returns the offset of given field/property in its source file – with a
    /// preference for the getter if it's defined.
    int _offsetFor(FieldElement e) {
      if (e.isSynthetic) {
        return (e.getter ?? e.setter)!.nameOffset;
      }
      return e.nameOffset;
    }

    return _offsetFor(a).compareTo(_offsetFor(b));
  }

  /// Returns `true` if [element] is annotated with [EnumKey].
  static bool _hasEnumKeyAnnotation(FieldElement element) =>
      _enumKeyAnnotation(element) != null;

  static DartObject? _enumKeyAnnotation(FieldElement element) =>
      _enumKeyChecker.firstAnnotationOf(element) ??
      (element.getter == null
          ? null
          : _enumKeyChecker.firstAnnotationOf(element.getter!));

  static const _enumKeyChecker = TypeChecker.fromRuntime(EnumKey);
}
