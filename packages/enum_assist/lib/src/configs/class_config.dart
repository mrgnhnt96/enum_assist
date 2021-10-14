import 'package:enum_assist/src/configs/additional_extension_config.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.class_config}
/// Represents most values from [EnumAssist] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
/// {@endtemplate}

class ClassConfig {
  /// {@macro enum_assist.class_config}
  const ClassConfig({
    required this.createJsonConv,
    required this.fieldFormat,
    required this.useDocCommentAsDescription,
    required this.additionalExtensions,
    required this.requiredExtensions,
  });

  /// Merges [config] with [reader].annotation
  ///
  /// priority is given to `annotation`
  factory ClassConfig.mergeConfigs(ClassConfig config, ConstantReader reader) {
    final annotation = _getAnnotation(reader);
    final additionalExtensions = _getAdditionalExtensions(reader);

    return ClassConfig(
      createJsonConv: annotation.createJsonConv ?? config.createJsonConv,
      fieldFormat: annotation.fieldFormat ?? config.fieldFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
      additionalExtensions: additionalExtensions ?? config.additionalExtensions,
      requiredExtensions: config.requiredExtensions,
    );
  }

  /// {@macro enum_assist_annotation.enum_assist.create_json_conv}
  final bool createJsonConv;

  /// {@macro enum_assist_annotation.enum_assist.field_format}
  final FieldFormat fieldFormat;

  /// {@macro enum_assist_annotation.enum_assist.use_doc_comment_as_description}
  final bool useDocCommentAsDescription;

  /// {@macro enum_assist_annotation.enum_assist.additional_methods}
  final List<AdditionalExtensionConfig> additionalExtensions;

  /// List of required extensions to add/check for each enum
  final List<String> requiredExtensions;

  /// all the default values for [ClassConfig]
  static const defaults = ClassConfig(
    createJsonConv: true,
    fieldFormat: FieldFormat.none,
    useDocCommentAsDescription: true,
    additionalExtensions: <AdditionalExtensionConfig>[],
    requiredExtensions: <String>[],
  );

  @override
  String toString() {
    return '''
ClassConfig{
  createJsonConv: $createJsonConv,
  fieldFormat: $fieldFormat,
  useDocCommentAsDescription: $useDocCommentAsDescription,
  additionalExtensions: $additionalExtensions
}
''';
  }
}

List<AdditionalExtensionConfig>? _getAdditionalExtensions(
    ConstantReader reader) {
  final additionalExtensionsRaw =
      reader.peek('additionalExtensions')?.listValue;

  if (additionalExtensionsRaw == null) return null;

  final additionalExtensions = <AdditionalExtensionConfig>[];
  for (final extension in additionalExtensionsRaw) {
    final entry = ConstantReader(extension);

    AdditionalExtensionConfig? config;
    try {
      config = AdditionalExtensionConfig.resolve(entry);
    } catch (e) {
      print('Error resolving extension:\n\nmessage: $e');
    }
    if (config == null) continue;

    additionalExtensions.add(config);
  }
  return additionalExtensions;
}

EnumAssist _getAnnotation(ConstantReader reader) {
  final fieldFormatObject = reader.peek('fieldFormat')?.objectValue;
  final fieldFormat = getEnumFromDartObject(
    fieldFormatObject,
    FieldFormat.values,
  );

  final createJsonConv = reader.peek('createJsonConv')?.boolValue;

  final useDocCommentAsDescription =
      reader.peek('useDocCommentAsDescription')?.boolValue;

  return EnumAssist(
    createJsonConv: createJsonConv,
    fieldFormat: fieldFormat,
    useDocCommentAsDescription: useDocCommentAsDescription,
  );
}
