import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.key_config}
/// Represents values from [EnumKey] when merged with local configuration.
/// {@endtemplate}
class KeyConfig implements EnumKey {
  /// {@macro enum_assist.key_config}
  const KeyConfig({
    required this.description,
    required this.name,
    required this.serializedValue,
    required this.useDocCommentAsDescription,
  });

  @override
  final String? description;

  @override
  final String? name;

  @override
  final String? serializedValue;

  @override
  final bool useDocCommentAsDescription;
}
