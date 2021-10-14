import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

/// {@template enum_assist_annotation.enum_assist}
/// Annotation to assist in generating code for enums.
/// {@endtemplate}
@Target({TargetKind.enumType})
class EnumAssist {
  /// {@macro enum_assist_annotation.enum_assist}
  const EnumAssist({
    this.createJsonConv,
    this.serializedFormat,
    this.useDocCommentAsDescription,
    this.additionalExtensions,
  });

  /// {@template enum_assist_annotation.enum_assist.create_json_conv}
  /// Whether to create a json converter for this enum,
  /// which can be used to convert between the enum
  /// and its string representation.
  ///
  /// If false, the json converter will not be generated.
  ///
  /// __default:__ `true`
  /// {@endtemplate}
  final bool? createJsonConv;

  /// {@template enum_assist_annotation.enum_assist.serialized_format}
  /// The format of the enum value when serialized.
  ///
  /// __default:__ `none`
  ///
  /// {@endtemplate}
  /// {@macro enum_assist_annotation.serialized_format.none}
  final SerializedFormat? serializedFormat;

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

  /// {@template enum_assist_annotation.enum_assist.additional_methods}
  /// Additional methods to generate for the enum.
  /// {@endtemplate}
  @JsonKey(ignore: true)
  final List<AdditionalExtension>? additionalExtensions;
}
