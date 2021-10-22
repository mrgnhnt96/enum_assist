import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

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

    final config = ClassConfig(
      enumName: '',
      createJsonConv: createJsonConvValue,
      serializedFormat: serializedFormatValue,
      useDocCommentAsDescription: useDocCommentAsDescriptionValue,
    );
    return Settings._(config);
  }

  final ClassConfig _config;

  /// {@macro enum_assist.settings}
  ClassConfig get config => _config;
}
