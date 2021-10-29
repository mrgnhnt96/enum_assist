import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

/// {@template enum_assist.settings}
/// Settings configured in the `build.yaml` file
/// {@endtemplate}
class Settings {
  /// {@macro enum_assist.settings}
  const Settings._(this._config);

  /// {@macro enum_assist.settings}
  ///
  /// Parses [json] to [Settings]
  ///
  /// If any property is null, [ClassConfig.defaults] will be used
  factory Settings.resolve(Map<String, dynamic> json) {
    const createJsonConvKey = 'create_json_conv';
    const serializedFormatKey = 'serialized_format';
    const useDocCommentAsDescriptionKey = 'use_doc_comment_as_description';
    const useIntValueForSerialization = 'use_int_value_for_serialization';

    const defaultVal = ClassConfig.defaults;

    final createJsonConvValue =
        json[createJsonConvKey] as bool? ?? defaultVal.createJsonConv;

    final useIntForSerializedValue =
        json[useIntValueForSerialization] as bool? ??
            defaultVal.useIntValueForSerialization;

    final serializedFormatString = json[serializedFormatKey] as String?;

    const serializedFormatConv = SerializedFormatConv();
    final serializedFormatValue = serializedFormatString == null
        ? defaultVal.serializedFormat
        : serializedFormatConv.fromJson(serializedFormatString);

    final useDocCommentAsDescriptionValue =
        json[useDocCommentAsDescriptionKey] as bool? ??
            defaultVal.useDocCommentAsDescription;

    final config = ClassConfig(
      enumName: defaultVal.enumName,
      createJsonConv: createJsonConvValue,
      serializedFormat: serializedFormatValue,
      useDocCommentAsDescription: useDocCommentAsDescriptionValue,
      useIntValueForSerialization: useIntForSerializedValue,
    );

    return Settings._(config);
  }

  /// Used for testing
  @visibleForTesting
  Settings.manual({
    String? enumName,
    bool? createJsonConv,
    SerializedFormat? serializedFormat,
    bool? useDocCommentAsDescription,
    bool? useIntValueForSerialization,
  }) : _config = ClassConfig(
          enumName: enumName ?? ClassConfig.defaults.enumName,
          createJsonConv: createJsonConv ?? ClassConfig.defaults.createJsonConv,
          serializedFormat:
              serializedFormat ?? ClassConfig.defaults.serializedFormat,
          useDocCommentAsDescription: useDocCommentAsDescription ??
              ClassConfig.defaults.useDocCommentAsDescription,
          useIntValueForSerialization: useIntValueForSerialization ??
              ClassConfig.defaults.useIntValueForSerialization,
        );

  final ClassConfig _config;

  /// {@macro enum_assist.settings}
  ClassConfig get config => _config;

  /// Used for testing
  @visibleForTesting
  Map<String, dynamic> toJson() {
    final json = {
      'create_json_conv': config.createJsonConv,
      'serialized_format': config.serializedFormat,
      'use_doc_comment_as_description': config.useDocCommentAsDescription,
      'use_int_value_for_serialization': config.useIntValueForSerialization,
    };

    return json;
  }
}
