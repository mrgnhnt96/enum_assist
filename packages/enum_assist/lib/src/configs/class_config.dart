import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

part 'class_config.g.dart';

/// {@template enum_assist.class_config}
/// Represents values from [EnumAssist] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
/// {@endtemplate}
@JsonSerializable(
  fieldRename: FieldRename.snake,
  disallowUnrecognizedKeys: true,
)
class ClassConfig implements EnumAssist {
  /// {@macro enum_assist.class_config}
  const ClassConfig({
    required this.createJsonConv,
    required this.fieldFormat,
    required this.useDocCommentAsDescription,
  });

  /// Merges [config] with [reader].annotation
  ///
  /// priority is given to `annotation`
  factory ClassConfig.mergeConfigs(ClassConfig config, ConstantReader reader) {
    final annotation = _valueForAnnotation(reader);

    return ClassConfig(
      createJsonConv: annotation.createJsonConv ?? config.createJsonConv,
      fieldFormat: annotation.fieldFormat ?? config.fieldFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
    );
  }

  @override
  final bool createJsonConv;

  @override
  final FieldFormat fieldFormat;

  @override
  final bool useDocCommentAsDescription;

  /// all the default values for [ClassConfig]
  static const defaults = ClassConfig(
    createJsonConv: true,
    fieldFormat: FieldFormat.none,
    useDocCommentAsDescription: true,
  );
}

EnumAssist _valueForAnnotation(ConstantReader reader) {
  FieldFormat? fieldFormat;
  final fieldFormatObject =
      reader.read(EnumAssist.fields.camel.fieldFormat).objectValue;

  String getName(FieldFormat format) => '$format'.split('.').last;
  fieldFormat = FieldFormat.values
      .singleWhere((v) => fieldFormatObject.getField(getName(v)) != null);

  final createJsonConv =
      reader.read(EnumAssist.fields.camel.createJsonConv).literalValue as bool?;

  final useDocCommentAsDescription = reader
      .read(EnumAssist.fields.camel.useDocCommentAsDescription)
      .literalValue as bool?;

  return EnumAssist(
    createJsonConv: createJsonConv,
    fieldFormat: fieldFormat,
    useDocCommentAsDescription: useDocCommentAsDescription,
  );
}
