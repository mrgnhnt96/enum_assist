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
    const createNameKey = 'create_name';
    const createDescriptionKey = 'create_description';
    const createToIntKey = 'create_to_int';
    const createReadableKey = 'create_readable';
    const createSerializedKey = 'create_serialized';
    const serializedFormatKey = 'serialized_format';
    const useDocCommentAsDescriptionKey = 'use_doc_comment_as_description';
    const useIntValueForSerialization = 'use_int_value_for_serialization';

    const defaultVal = ClassConfig.defaults;

    final createJsonConvValue =
        json[createJsonConvKey] as bool? ?? defaultVal.createJsonConv;

    final createNameValue =
        json[createNameKey] as bool? ?? defaultVal.createName;

    final createDescriptionValue =
        json[createDescriptionKey] as bool? ?? defaultVal.createDescription;

    final createToIntValue =
        json[createToIntKey] as bool? ?? defaultVal.createToInt;

    final createReadableValue =
        json[createReadableKey] as bool? ?? defaultVal.createReadable;

    final createSerializedValue =
        json[createSerializedKey] as bool? ?? defaultVal.createSerialized;

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
      createName: createNameValue,
      createDescription: createDescriptionValue,
      createToInt: createToIntValue,
      createReadable: createReadableValue,
      createSerialized: createSerializedValue,
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
    bool? createName,
    bool? createDescription,
    bool? createToInt,
    bool? createReadable,
    bool? createSerialized,
    SerializedFormat? serializedFormat,
    bool? useDocCommentAsDescription,
    bool? useIntValueForSerialization,
  }) : _config = ClassConfig(
          enumName: enumName ?? ClassConfig.defaults.enumName,
          createJsonConv: createJsonConv ?? ClassConfig.defaults.createJsonConv,
          createName: createName ?? ClassConfig.defaults.createName,
          createDescription:
              createDescription ?? ClassConfig.defaults.createDescription,
          createToInt: createToInt ?? ClassConfig.defaults.createToInt,
          createReadable: createReadable ?? ClassConfig.defaults.createReadable,
          createSerialized:
              createSerialized ?? ClassConfig.defaults.createSerialized,
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
      'create_name': config.createName,
      'create_description': config.createDescription,
      'create_to_int': config.createToInt,
      'create_readable': config.createReadable,
      'create_serialized': config.createSerialized,
      'serialized_format': config.serializedFormat,
      'use_doc_comment_as_description': config.useDocCommentAsDescription,
      'use_int_value_for_serialization': config.useIntValueForSerialization,
    };

    return json;
  }
}
