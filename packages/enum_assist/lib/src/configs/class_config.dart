import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

part 'class_config.g.dart';

/// Represents values from [EnumAssist] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
@JsonSerializable(
  fieldRename: FieldRename.snake,
  disallowUnrecognizedKeys: true,
)
class ClassConfig implements EnumAssist {
  const ClassConfig({
    required this.createJsonConv,
    required this.fieldFormat,
    required this.useDocCommentAsDescription,
  });

  @override
  final bool createJsonConv;

  @override
  final FieldFormat fieldFormat;

  @override
  final bool useDocCommentAsDescription;

  static const defaults = ClassConfig(
    createJsonConv: true,
    fieldFormat: FieldFormat.none,
    useDocCommentAsDescription: true,
  );

  factory ClassConfig.mergeConfigs(
    ClassConfig config,
    ConstantReader reader, {
    required ClassElement classElement,
  }) {
    final annotation = _valueForAnnotation(reader);

    return ClassConfig(
      createJsonConv: annotation.createJsonConv ?? config.createJsonConv,
      fieldFormat: annotation.fieldFormat ?? config.fieldFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
    );
  }
}

EnumAssist _valueForAnnotation(ConstantReader reader) {
  final fieldFormatConv = FieldFormatConv();
  return EnumAssist(
    createJsonConv:
        reader.read(EnumAssist.fields.createJsonConv).literalValue as bool,
    fieldFormat: fieldFormatConv.fromJson(
        reader.read(EnumAssist.fields.fieldFormat).literalValue as String),
    useDocCommentAsDescription: reader
        .read(EnumAssist.fields.useDocCommentAsDescription)
        .literalValue as bool,
  );
}
