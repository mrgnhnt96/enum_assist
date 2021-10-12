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
    const fieldFormatKey = 'field_format';
    const useDocCommentAsDescriptionKey = 'use_doc_comment_as_description';
    const requiredExtensionsKey = 'required_extensions';

    final defaultVal = ClassConfig.defaults;

    final createJsonConvValue =
        json[createJsonConvKey] as bool? ?? defaultVal.createJsonConv;

    final fieldFormatString = json[fieldFormatKey] as String?;

    const fieldFormatConv = FieldFormatConv();
    final fieldFormatValue = fieldFormatString == null
        ? defaultVal.fieldFormat
        : fieldFormatConv.fromJson(fieldFormatString);

    final useDocCommentAsDescriptionValue =
        json[useDocCommentAsDescriptionKey] as bool? ??
            defaultVal.useDocCommentAsDescription;

    final additionalExtensionsValue = defaultVal.additionalExtensions;

    final requiredExtensionsValue =
        json[requiredExtensionsKey] as List<String>? ??
            defaultVal.requiredExtensions;

    final config = ClassConfig(
      createJsonConv: createJsonConvValue,
      fieldFormat: fieldFormatValue,
      useDocCommentAsDescription: useDocCommentAsDescriptionValue,
      additionalExtensions: additionalExtensionsValue,
      requiredExtensions: requiredExtensionsValue,
    );
    return Settings._(config);
  }

  final ClassConfig _config;

  /// {@macro enum_assist.settings}
  ClassConfig get config => _config;
}
