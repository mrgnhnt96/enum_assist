import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.settings}
/// Represents the settings to use when generating code.
/// {@endtemplate}
class Settings {
  /// {@macro enum_assist.settings}
  const Settings({EnumAssist? config})
      : _config = config ?? ClassConfig.defaults;

  final EnumAssist _config;

  /// retrieves the [EnumAssist] configuration
  ClassConfig get config => ClassConfig(
        createJsonConv:
            _config.createJsonConv ?? ClassConfig.defaults.createJsonConv,
        fieldFormat: _config.fieldFormat ?? ClassConfig.defaults.fieldFormat,
        useDocCommentAsDescription: _config.useDocCommentAsDescription ??
            ClassConfig.defaults.useDocCommentAsDescription,
        additionalMethods:
            _config.additionalMethods ?? ClassConfig.defaults.additionalMethods,
      );
}
