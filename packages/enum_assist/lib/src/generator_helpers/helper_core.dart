// ignore_for_file: implementation_imports, comment_references
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/source_helper.dart';

/// {@template enum_assist.helper_core}
/// A helper class that provides the core functionality for generating
/// [EnumHelper]s.
/// {@endtemplate}
abstract class HelperCore {
  /// {@macro enum_assist.helper_core}
  HelperCore(this.element, this.config) : assert(element.isEnum);

  /// The [ClassElement] that this helper is for.
  final ClassElement element;

  /// The [ClassConfig] for this helper.
  final ClassConfig config;

  /// The method to use for generating the code
  Iterable<String> generate();

  /// The name of the enum value for the given [field].
  String _nameAccess(FieldElement field) => field.name;

  /// the name of the enum
  @protected
  String get enumName => element.name.nonPrivate;

  /// Returns a [Set] of all instance [FieldElement] items for [element] and
  /// super classes, sorted first by their location in the inheritance hierarchy
  /// (super first) and then by their location in the source file.
  @protected
  Iterable<FieldElement> get fieldElements {
    // Get all of the fields that need to be assigned
    final elementInstanceFields = element.fields.where((e) => e.isEnumConstant);

    return elementInstanceFields.toSet();
  }

  /// Returns the names of all fields
  @protected
  Iterable<String> get fieldNames => fieldElements.map(_nameAccess);
}
