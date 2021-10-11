import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// Represents values from [EnumKey] when merged with local configuration.
class KeyConfig implements EnumKey {
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
