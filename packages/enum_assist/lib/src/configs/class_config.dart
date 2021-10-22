import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

/// {@template enum_assist.class_config}
/// Represents most values from [EnumAssist] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
/// {@endtemplate}

class ClassConfig {
  /// {@macro enum_assist.class_config}
  const ClassConfig({
    required this.enumName,
    required this.createJsonConv,
    required this.serializedFormat,
    required this.useDocCommentAsDescription,
  });

  /// Merges [config] and the [EnumAssist] annotation
  ///
  /// priority is given to the `annotation`
  factory ClassConfig.mergeConfigs(
      ClassElement element, ClassConfig config, ConstantReader reader) {
    final annotation = _getAnnotation(reader);

    return ClassConfig(
      enumName: element.name.nonPrivate,
      createJsonConv: annotation.createJsonConv ?? config.createJsonConv,
      serializedFormat: annotation.serializedFormat ?? config.serializedFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
    );
  }

  /// The name of the enum
  final String enumName;

  /// [EnumAssist.createJsonConv]
  final bool createJsonConv;

  /// [EnumAssist.serializedFormat]
  final SerializedFormat serializedFormat;

  /// [EnumAssist.useDocCommentAsDescription]
  final bool useDocCommentAsDescription;

  /// all the default values for [ClassConfig]
  static const defaults = ClassConfig(
    enumName: '',
    createJsonConv: true,
    serializedFormat: SerializedFormat.none,
    useDocCommentAsDescription: true,
  );

  @override
  String toString() {
    return '''
ClassConfig{
  createJsonConv: $createJsonConv,
  serializedFormat: $serializedFormat,
  useDocCommentAsDescription: $useDocCommentAsDescription,
}
''';
  }
}

EnumAssist _getAnnotation(ConstantReader reader) {
  final serializedFormatObject = reader.peek('serializedFormat')?.objectValue;
  final serializedFormat = getEnumFromDartObject(
    serializedFormatObject,
    SerializedFormat.values,
  );

  final createJsonConv = reader.peek('createJsonConv')?.boolValue;

  final useDocCommentAsDescription =
      reader.peek('useDocCommentAsDescription')?.boolValue;

  return EnumAssist(
    createJsonConv: createJsonConv,
    serializedFormat: serializedFormat,
    useDocCommentAsDescription: useDocCommentAsDescription,
  );
}
