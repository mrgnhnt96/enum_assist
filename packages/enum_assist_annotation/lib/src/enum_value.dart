import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist_annotation.enum_value}
/// Annotation to assist in generating code for enum values.
/// {@endtemplate}
///
/// ---
///
/// ## Name
/// {@macro enum_assist_annotation.enum_value.name}
///
/// ---
///
/// ## Description
/// {@macro enum_assist_annotation.enum_value.description}
///
/// ---
///
/// ## Serialized Value
/// {@macro enum_assist_annotation.enum_value.serialized_value}
///
/// ---
///
/// ## Int Value
/// {@macro enum_assist_annotation.enum_value.int_value}
///
/// ---
///
/// ## Use Doc Comment As Description
/// {@macro enum_assist_annotation.enum_assist.use_doc_comment_as_description}
///
/// ---
///
/// ## Extensions
/// {@macro enum_assist_annotation.enum_value.extensions}
class EnumValue {
  /// {@macro enum_assist_annotation.enum_value}
  const EnumValue({
    this.readable,
    this.description,
    this.intValue,
    this.serializedValue,
    this.useDocCommentAsDescription,
    this.extensions,
  });

  /// {@template enum_assist_annotation.enum_value.name}
  /// The name of the enum value, should be formatted as a human readable name
  ///
  /// Extension Method: `readable`
  ///
  /// __default:__ The name will be converted to Capital Case
  ///
  /// (e.g. `isNotAvailable` => `Is Not Available`)
  /// {@endtemplate}
  final String? readable;

  /// {@template enum_assist_annotation.enum_value.description}
  /// The description of the enum value
  ///
  /// Extension Method: `description`
  ///
  /// __default:__ The description will be generated from the doc comment
  /// or `null` if [EnumAssist.useDocCommentAsDescription] is set to `false`\
  /// (either annotation or build.yaml file)
  /// {@endtemplate}
  final String? description;

  /// {@template enum_assist_annotation.enum_value.int_value}
  /// The enum value converted to an integer\
  /// Incremented by 1 based on the previous enum value
  ///
  /// (e.g. `one` => 0, `two` => 200, `three` => 201, `four` => 202)
  ///
  /// Extension Method: `toInt`
  ///
  /// __default:__ 0 indexed & incremented by 1
  ///
  /// {@endtemplate}
  final int? intValue;

  /// {@template enum_assist_annotation.enum_value.serialized_value}
  /// The serialized represenation of the enum value.
  ///
  /// Can be manipulated via [EnumAssist.serializedFormat]\
  /// (either annotation or build.yaml file)
  ///
  /// Extension Method: `serialized`\
  /// Classes Where Referenced: `ExampleConv` & `_ExampleNullableConv`
  ///
  /// __default:__ Non-formatted name of the enum value
  /// {@endtemplate}
  final Object? serializedValue;

  // ignore: lines_longer_than_80_chars
  /// {@template enum_assist_annotation.enum_value.use_doc_comment_as_description}
  /// Whether to use the doc comment of the enum for the `description` method.
  ///
  /// [EnumValue.description] will override the doc comment description.
  ///
  /// If false, the description will return `null`
  /// unless overridden by [EnumValue.description].
  ///
  /// __default:__ `true`
  /// {@endtemplate}
  final bool? useDocCommentAsDescription;

  /// {@template enum_assist_annotation.enum_value.extensions}
  /// Methods to be generated for the enum
  ///
  /// Defined classes must extend [MapExtension] or [MaybeExtension]
  ///
  /// __default:__ []
  /// {@endtemplate}
  final List<Extension>? extensions;
}
