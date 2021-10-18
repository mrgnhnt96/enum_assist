import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/additional_extension_config.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

/// {@template enum_assist.class_config}
/// Represents most values from [EnumAssist] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
/// {@endtemplate}

class ClassConfig {
  /// {@macro enum_assist.class_config}
  const ClassConfig({
    required this.enumName,
    required this.createJsonConv,
    required this.serializedFormat,
    required this.useDocCommentAsDescription,
    required this.additionalExtensions,
  });

  /// Merges [config] with [reader].annotation
  ///
  /// priority is given to `annotation`
  factory ClassConfig.mergeConfigs(
      ClassElement element, ClassConfig config, ConstantReader reader) {
    final annotation = _getAnnotation(reader);
    final additionalExtensions = _getAdditionalExtensions(reader, element);

    return ClassConfig(
      enumName: element.name.nonPrivate,
      createJsonConv: annotation.createJsonConv ?? config.createJsonConv,
      serializedFormat: annotation.serializedFormat ?? config.serializedFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
      additionalExtensions: additionalExtensions ?? config.additionalExtensions,
    );
  }

  ///
  final String enumName;

  /// {@macro enum_assist_annotation.enum_assist.create_json_conv}
  final bool createJsonConv;

  /// {@macro enum_assist_annotation.enum_assist.serialized_format}
  final SerializedFormat serializedFormat;

  /// {@macro enum_assist_annotation.enum_assist.use_doc_comment_as_description}
  final bool useDocCommentAsDescription;

  /// {@macro enum_assist_annotation.enum_assist.additional_methods}
  final List<AdditionalExtensionConfig> additionalExtensions;

  /// all the default values for [ClassConfig]
  static const defaults = ClassConfig(
    enumName: '',
    createJsonConv: true,
    serializedFormat: SerializedFormat.none,
    useDocCommentAsDescription: true,
    additionalExtensions: <AdditionalExtensionConfig>[],
  );

  @override
  String toString() {
    return '''
ClassConfig{
  createJsonConv: $createJsonConv,
  serializedFormat: $serializedFormat,
  useDocCommentAsDescription: $useDocCommentAsDescription,
  additionalExtensions: $additionalExtensions
}
''';
  }
}

List<AdditionalExtensionConfig>? _getAdditionalExtensions(
  ConstantReader reader,
  ClassElement element,
) {
  final additionalExtensionsRaw =
      reader.peek('additionalExtensions')?.listValue;

  if (additionalExtensionsRaw == null) return null;

  final additionalExtensions = <AdditionalExtensionConfig>[];
  for (final extension in additionalExtensionsRaw) {
    final entry = ConstantReader(extension);

    AdditionalExtensionConfig? config;
    try {
      config = AdditionalExtensionConfig.resolve(element, entry);
    } catch (e) {
      print('Error resolving extension:\n\nmessage: $e'); // ignore: avoid_print
    }
    if (config == null) continue;

    additionalExtensions.add(config);
  }
  return additionalExtensions;
}

EnumAssist _getAnnotation(ConstantReader reader) {
  final serializedFormatObject = reader.peek('serializedFormat')?.objectValue;
  final serializedFormat = getEnumFromDartObject(
    serializedFormatObject,
    SerializedFormat.values,
  );

  final createJsonConv = reader.peek('createJsonConv')?.boolValue;

  final useDocCommentAsDescription =
      reader.peek('useDocCommentAsDescription')?.boolValue;

  return EnumAssist(
    createJsonConv: createJsonConv,
    serializedFormat: serializedFormat,
    useDocCommentAsDescription: useDocCommentAsDescription,
  );
}
