import 'package:json_annotation/json_annotation.dart';

part 'enum_key.g.dart';

/// {@template enum_assist_annotation.enum_key}
/// Annotation to assist in generating code for enum values.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class EnumKey {
  /// {@macro enum_assist_annotation.enum_key}
  const EnumKey({
    this.name,
    this.description,
    this.serializedValue,
    this.useDocCommentAsDescription,
  });

  /// {@template enum_assist_annotation.enum_key.name}
  /// The name of the enum value, should be formatted as a human readable name.
  ///
  /// (e.g. `isNotAvailable` could be formatted as `Is Not Available`)
  ///
  /// Used for the getter `name` extension method.
  ///
  /// If not specified, the `describeEnum` will be used.
  /// {@endtemplate}
  final String? name;

  /// {@template enum_assist_annotation.enum_key.description}
  /// The description of the enum value
  ///
  /// Used for the getter `description` extension method.
  ///
  /// If not specified, will `.description` return null for this value.
  /// {@endtemplate}
  final String? description;

  /// {@template enum_assist_annotation.enum_key.serialized_value}
  /// The serialized value of the enum
  ///
  /// To be used only if the desired value cannot be
  /// achieved by using `EnumAssist.fieldFormat`
  final String? serializedValue;

  /// {@macro enum_assist_annotation.enum_assist.use_doc_comment_as_description}
  final bool? useDocCommentAsDescription;

  /// Access serialized names of fields from [EnumKey]
  static _$EnumKeyFields get fields => const _$EnumKeyFields();
}
