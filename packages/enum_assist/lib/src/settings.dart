import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.settings}
/// Represents the settings to use when generating code.
/// {@endtemplate}
class Settings {
  /// {@macro enum_assist.settings}
  const Settings._(this._config);

  /// Resolve the settings from the build.yaml file.
  ///
  /// {@macro enum_assist.settings}
  factory Settings.resolve(Map<String, dynamic> json) {
    const createJsonConvKey = 'create_json_conv';
    const serializedFormatKey = 'serialized_format';
    const useDocCommentAsDescriptionKey = 'use_doc_comment_as_description';

    const defaultVal = ClassConfig.defaults;

    final createJsonConvValue =
        json[createJsonConvKey] as bool? ?? defaultVal.createJsonConv;

    final serializedFormatString = json[serializedFormatKey] as String?;

    const serializedFormatConv = SerializedFormatConv();
    final serializedFormatValue = serializedFormatString == null
        ? defaultVal.serializedFormat
        : serializedFormatConv.fromJson(serializedFormatString);

    final useDocCommentAsDescriptionValue =
        json[useDocCommentAsDescriptionKey] as bool? ??
            defaultVal.useDocCommentAsDescription;

    final additionalExtensionsValue = defaultVal.additionalExtensions;

    final config = ClassConfig(
      createJsonConv: createJsonConvValue,
      serializedFormat: serializedFormatValue,
      useDocCommentAsDescription: useDocCommentAsDescriptionValue,
      additionalExtensions: additionalExtensionsValue,
    );
    return Settings._(config);
  }

  final ClassConfig _config;

  /// {@macro enum_assist.settings}
  ClassConfig get config => _config;
}
