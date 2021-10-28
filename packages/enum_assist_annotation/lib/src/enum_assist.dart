// ignore_for_file: comment_references
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta_meta.dart';

/// {@template enum_assist_annotation.enum_assist}
/// Annotation to assist enums with generating code.
///
/// ## Generated Methods
/// - map
///    - Is the equivalent to pattern matching
///
/// - maybeMap
///    - Same as `map`, but doesn't require all callbacks to be specified
///    - Returns `orElse` value, or null if [MaybeExtension.allowNulls] is true
///
/// - name
///    - Returns the name of the enum value
///    - Formats the field to capital case unless overridden with @EnumKey.name
///
/// - toInt
///   - Returns the int value of the enum field
///
/// - description
///    - Returns the description of the enum field
///    - Uses the doc comment of the field unless overridden with
///        @EnumKey.description or
///        @EnumAssist.useDocCommentAsDescription is set to false
///        (either annotation or build.yaml file)
///    - Uses the @EnumKey.description if overridden in annotation
///
/// - serialized
///    - Returns the serialized value of the enum field, the default
///        format is the name of the enum value
///    - Uses the @EnumKey.serialized if overridden in annotation
///    - Can be formatted via @EnumAssist.serializedFormat
///        (either annotation or build.yaml file)
///
/// -----------
///
/// ## Generated Classes
/// _optionally generated, prevent generation via @EnumAssist.createJsonConv\
/// (either annotation or build.yaml file)_
///
/// __Classes extend `JsonConverter`, from
/// [json_serializable](https://pub.dev/packages/json_serializable)
/// for conversion__
/// - ExampleConv
///    - Convert non-nullable fields to and from json
///    - Can annotate fields in model class's fields\
///        `@ExampleConv()`
///
/// - _ExampleNullableConv (private class)
///    - Convert nullable fields to and from json
///    - Can annotate fields in model classes\
///        `@ExampleConv.nullable`
/// {@endtemplate}
@Target({TargetKind.enumType})
class EnumAssist {
  /// {@macro enum_assist_annotation.enum_assist}
  const EnumAssist({
    this.createJsonConv,
    this.serializedFormat,
    this.useDocCommentAsDescription,
    this.useIntValueForSerialization,
  });

  /// {@template enum_assist_annotation.enum_assist.create_json_conv}
  /// Whether to create a json converter for this enum
  ///
  /// Can be used to convert between the enum
  /// and its string (serialized) representation.
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
  ///
  /// [SerializedFormat.none] :
  /// {@macro enum_assist_annotation.serialized_format.none}
  final SerializedFormat? serializedFormat;

  // ignore: lines_longer_than_80_chars
  /// {@template enum_assist_annotation.enum_assist.use_doc_comment_as_description}
  /// Whether to use the doc comment of the enum for the `description` method.
  ///
  /// [EnumKey.description] will override the doc comment description.
  ///
  /// If false, the description will return `null`
  /// unless overridden by [EnumKey.description].
  ///
  /// __default:__ `true`
  /// {@endtemplate}
  final bool? useDocCommentAsDescription;

  /// {@template enum_assist_annotation.enum_assist.use_to_int_for_serialized}
  /// Whether to use the `toInt` value of the enum field for toJson/fromJson
  /// & `serialized` method.
  ///
  /// Setting this to `true` will override the [EnumKey.serialized] value.
  ///
  /// __default:__ `false`
  /// {@endtemplate}
  final bool? useIntValueForSerialization;
}
