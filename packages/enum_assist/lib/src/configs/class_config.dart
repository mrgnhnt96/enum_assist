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
    required this.createName,
    required this.createDescription,
    required this.createToInt,
    required this.createReadable,
    required this.createSerialized,
    required this.serializedFormat,
    required this.useDocCommentAsDescription,
    required this.useIntValueForSerialization,
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
      createName: annotation.createName ?? config.createName,
      createDescription:
          annotation.createDescription ?? config.createDescription,
      createToInt: annotation.createToInt ?? config.createToInt,
      createReadable: annotation.createReadable ?? config.createReadable,
      createSerialized: annotation.createSerialized ?? config.createSerialized,
      serializedFormat: annotation.serializedFormat ?? config.serializedFormat,
      useDocCommentAsDescription: annotation.useDocCommentAsDescription ??
          config.useDocCommentAsDescription,
      useIntValueForSerialization: annotation.useIntValueForSerialization ??
          defaults.useIntValueForSerialization,
    );
  }

  /// The name of the enum
  final String enumName;

  /// [EnumAssist.createJsonConv]
  final bool createJsonConv;

  /// [EnumAssist.createName]
  final bool createName;

  /// [EnumAssist.createDescription]
  final bool createDescription;

  /// [EnumAssist.createToInt]
  final bool createToInt;

  /// [EnumAssist.createReadable]
  final bool createReadable;

  /// [EnumAssist.createSerialized]
  final bool createSerialized;

  /// [EnumAssist.serializedFormat]
  final SerializedFormat serializedFormat;

  /// [EnumAssist.useDocCommentAsDescription]
  final bool useDocCommentAsDescription;

  /// [EnumAssist.useIntValueForSerialization]
  final bool useIntValueForSerialization;

  /// all the default values for [ClassConfig]
  static const defaults = ClassConfig(
    enumName: '',
    createJsonConv: true,
    createName: true,
    createDescription: true,
    createToInt: true,
    createReadable: true,
    createSerialized: true,
    serializedFormat: SerializedFormat.none,
    useDocCommentAsDescription: true,
    useIntValueForSerialization: false,
  );

  @override
  String toString() {
    return '''
ClassConfig{
  createJsonConv: $createJsonConv,
  createName: $createName,
  createDescription: $createDescription,
  createToInt: $createToInt,
  createReadable: $createReadable,
  createSerialized: $createSerialized,
  serializedFormat: $serializedFormat,
  useDocCommentAsDescription: $useDocCommentAsDescription,
  useIntValueForSerialization: $useIntValueForSerialization,
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
  final createName = reader.peek('createName')?.boolValue;
  final createDescription = reader.peek('createDescription')?.boolValue;
  final createToInt = reader.peek('createToInt')?.boolValue;
  final createReadable = reader.peek('createReadable')?.boolValue;
  final createSerialized = reader.peek('createSerialized')?.boolValue;

  final useDocCommentAsDescription =
      reader.peek('useDocCommentAsDescription')?.boolValue;

  final useIntValueForSerialization =
      reader.peek('useIntValueForSerialization')?.boolValue;

  return EnumAssist(
    createJsonConv: createJsonConv,
    createName: createName,
    createDescription: createDescription,
    createToInt: createToInt,
    createReadable: createReadable,
    createSerialized: createSerialized,
    serializedFormat: serializedFormat,
    useDocCommentAsDescription: useDocCommentAsDescription,
    useIntValueForSerialization: useIntValueForSerialization,
  );
}
