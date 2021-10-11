// ignore_for_file: implementation_imports, comment_references
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart'
    show InheritanceManager3;
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/util/field_set.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

/// {@template enum_assist.helper_core}
/// A helper class that provides the core functionality for generating
/// [EnumHelper]s.
/// {@endtemplate}
abstract class HelperCore {
  /// {@macro enum_assist.helper_core}
  const HelperCore(this.element, this.config);

  /// The [ClassElement] that this helper is for.
  final ClassElement element;

  /// The [ClassConfig] for this helper.
  final ClassConfig config;

  /// The method to use for generating the code
  Iterable<String> generate();

  /// The name of the enum value for the given [field].
  @protected
  String nameAccess(FieldElement field) => field.name;

  /// The name of the enum value for the given [field].
  ///
  /// _Removes all invalid characters from the name_
  @protected
  String safeNameAccess(FieldElement field) =>
      escapeDartString(nameAccess(field));

  /// the name of the enum
  @protected
  String get prefix => '_\$${element.name.nonPrivate}';

  /// Returns a [Set] of all instance [FieldElement] items for [element] and
  /// super classes, sorted first by their location in the inheritance hierarchy
  /// (super first) and then by their location in the source file.
  @protected
  Iterable<FieldElement> get sortedFieldSet {
    // Get all of the fields that need to be assigned
    final elementInstanceFields = Map.fromEntries(element.fields
        .where((e) => !e.isStatic)
        .map((e) => MapEntry(e.name, e)));

    final inheritedFields = <String, FieldElement>{};
    final manager = InheritanceManager3();

    for (final v in manager.getInheritedConcreteMap2(element).values) {
      assert(v is! FieldElement);
      if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
        continue;
      }

      if (v is PropertyAccessorElement && v.isGetter) {
        assert(v.variable is FieldElement);
        final variable = v.variable as FieldElement;
        assert(!inheritedFields.containsKey(variable.name));
        inheritedFields[variable.name] = variable;
      }
    }

    // Get the list of all fields for `element`
    final allFields =
        elementInstanceFields.keys.toSet().union(inheritedFields.keys.toSet());

    final fields = allFields
        .map((e) => FieldSet(elementInstanceFields[e], inheritedFields[e]))
        .toList()
      ..sort();

    return fields.map((fs) => fs.field).toList();
  }

  static const _dartCoreObjectChecker = TypeChecker.fromRuntime(Object);
}
