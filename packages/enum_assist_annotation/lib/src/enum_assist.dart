import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

part 'enum_assist.g.dart';

/// {@template enum_assist_annotation.enum_assist}
/// Annotation to assist in generating code for enums.
/// {@endtemplate}
@Target({TargetKind.enumType})
@JsonSerializable(createToJson: false)
class EnumAssist {
  /// {@macro enum_assist_annotation.enum_assist}
  const EnumAssist({
    this.createJsonConv,
    this.fieldFormat,
    this.useDocCommentAsDescription,
  });

  /// {@template enum_assist_annotation.enum_assist.create_json_conv}
  /// Whether to create a json converter for this enum,
  /// which can be used to convert between the enum
  /// and its string representation.
  ///
  /// If false, the json converter will not be generated.
  ///
  /// __default:__ `true`
  final bool? createJsonConv;

  /// {@template enum_assist_annotation.enum_assist.field_format}
  /// The format of the enum value when serialized.
  ///
  /// __default:__ `none`
  ///
  /// {@endtemplate}
  /// {@macro enum_assist_annotation.field_format.none}
  final FieldFormat? fieldFormat;

  // ignore: lines_longer_than_80_chars
  /// {@template enum_assist_annotation.enum_assist.use_doc_comment_as_description}
  /// Whether to use the doc comment of the enum for the getter `description`.
  ///
  /// `EnumKey.description` will override the doc comment description.
  ///
  /// If false, the description will return `null`
  /// unless overridden by `EnumKey.description`.
  ///
  /// __default:__ `true`
  /// {@endtemplate}
  final bool? useDocCommentAsDescription;

  /// converts Map to EnumAssist
  static EnumAssist fromJson(Map<String, dynamic> json) =>
      _$EnumAssistFromJson(json);

  /// retrieves all field keys for [EnumAssist]
  static _$EnumAssistFields get fields => const _$EnumAssistFields();
}
