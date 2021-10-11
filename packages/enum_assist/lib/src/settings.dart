import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class Settings {
  final EnumAssist _config;

  ClassConfig get config => ClassConfig(
        createJsonConv:
            _config.createJsonConv ?? ClassConfig.defaults.createJsonConv,
        fieldFormat: _config.fieldFormat ?? ClassConfig.defaults.fieldFormat,
        useDocCommentAsDescription: _config.useDocCommentAsDescription ??
            ClassConfig.defaults.useDocCommentAsDescription,
      );

  const Settings({EnumAssist? config})
      : _config = config ?? ClassConfig.defaults;
}
