// ignore_for_file: implementation_imports, comment_references
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:enum_assist/src/field_data.dart';
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

  /// the name of the enum
  @protected
  @visibleForTesting
  String get enumName => element.name.nonPrivate;

  /// Returns a [Set] of all instance [FieldElement] items for [element] and
  /// super classes, sorted first by their location in the inheritance hierarchy
  /// (super first) and then by their location in the source file.
  @protected
  Iterable<FieldData> get fieldData {
    final fields = <FieldData>[];

    for (final field in element.fields) {
      if (!field.isEnumConstant) continue;

      final data = FieldData.config(field, config);

      fields.add(data);
    }

    return fields;
  }

  /// Returns the names of all fields
  @protected
  @visibleForTesting
  Iterable<String> get fieldNames => fieldData.map((e) => e.fieldName);

  /// returns all extensions from all fields
  Map<String, ExtensionConfig> get extensions {
    return fieldData
        .map((e) => e.extensions)
        .fold<Map<String, ExtensionConfig>>({}, (m, e) => {...m, ...e});
  }
}
