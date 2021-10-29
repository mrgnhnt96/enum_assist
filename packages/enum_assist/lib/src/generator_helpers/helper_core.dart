// ignore_for_file: implementation_imports, comment_references
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:enum_assist/src/field_data.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/source_helper.dart';

/// {@template enum_assist.helper_core}
/// A helper class that provides the core functionality for generating
/// extensions and classes for enums.
/// {@endtemplate}
abstract class HelperCore {
  /// {@macro enum_assist.helper_core}
  HelperCore(this.element, this.config) : assert(element.isEnum);

  /// The enum ([ClassElement]) that this helper is generating code for.
  final ClassElement element;

  /// The [ClassConfig] for this generator.
  final ClassConfig config;

  /// The method to use for generating the code
  Iterable<String> generate();

  /// the name of the enum
  @protected
  @visibleForTesting
  String get enumName => element.name.nonPrivate;

  /// Converts [FieldElement] to List<[FieldData]>
  ///
  /// Converts all [EnumValue] annotations to [FieldData]
  @protected
  Iterable<FieldData> get fieldData {
    final fields = <FieldData>[];
    final intValues = <int>[];

    var index = 0;
    for (final field in element.fields) {
      if (!field.isEnumConstant) continue;

      final data = FieldData.config(field, config, index++);

      if (data.index == 0) {
        intValues.add(data.intValue ?? 0);
      } else {
        intValues.add(data.intValue ?? intValues.last + 1);
      }

      fields.add(data.copyWith(intValue: intValues.last));
    }

    return fields;
  }

  /// Returns all enum's field names, [FieldData.fieldName]
  @protected
  @visibleForTesting
  Iterable<String> get fieldNames => fieldData.map((e) => e.fieldName);

  /// __Returns__ Map<[ExtensionConfig.methodName], [ExtensionConfig]>
  ///
  /// Gets all the extensions that should be generated for this enum.
  Map<String, ExtensionConfig> get extensions {
    return fieldData
        .map((e) => e.extensions)
        .fold<Map<String, ExtensionConfig>>({}, (m, e) => {...m, ...e});
  }
}
