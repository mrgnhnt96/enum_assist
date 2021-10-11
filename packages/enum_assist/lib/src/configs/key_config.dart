import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/configs.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.key_config}
/// Represents values from the [EnumKey] annotation.
/// {@endtemplate}
class KeyConfig implements EnumKey {
  /// {@macro enum_assist.key_config}
  const KeyConfig({
    required this.description,
    required this.name,
    required this.serializedValue,
    required this.useDocCommentAsDescription,
  });

  /// {@macro enum_assist.key_config}
  KeyConfig.fromSettings(KeyConfig settings)
      : this(
          description: settings.description,
          name: settings.name,
          serializedValue: settings.serializedValue,
          useDocCommentAsDescription: settings.useDocCommentAsDescription,
        );

  /// Constructs the key configs from the [EnumKey] annotation.
  ///
  /// {@macro enum_assist.key_config}
  factory KeyConfig.mergeConfigs(
    ClassConfig classConfig,
    FieldElement element,
  ) {
    final result = _getConfigFromAnnotation(element);

    return KeyConfig(
      name: result.name,
      description: result.description,
      serializedValue: result.serializedValue,
      useDocCommentAsDescription: result.useDocCommentAsDescription ??
          classConfig.useDocCommentAsDescription,
    );
  }

  @override
  final String? description;

  @override
  final String? name;

  @override
  final String? serializedValue;

  @override
  final bool useDocCommentAsDescription;

  /// all the default values of [EnumKey]
  static const defaults = KeyConfig(
    name: null,
    description: null,
    serializedValue: null,
    useDocCommentAsDescription: true,
  );

  static const _enumKeyChecker = TypeChecker.fromRuntime(EnumKey);

  static EnumKey _getConfigFromAnnotation(FieldElement element) {
    DartObject? object;
    object = _enumKeyChecker.firstAnnotationOf(element);

    if (object == null) {
      if (element.getter != null) {
        object = _enumKeyChecker.firstAnnotationOf(element.getter!);
      }
    }

    if (object == null) return KeyConfig.defaults;

    final reader = ConstantReader(object);

    final name = reader.read(EnumKey.fields.name).literalValue as String?;

    final description =
        reader.read(EnumKey.fields.description).literalValue as String?;

    final serializedValue =
        reader.read(EnumKey.fields.serializedValue).literalValue as String?;

    final useDocCommentAsDescription = reader
        .read(EnumKey.fields.useDocCommentAsDescription)
        .literalValue as bool?;

    return EnumKey(
      name: name,
      description: description,
      serializedValue: serializedValue,
      useDocCommentAsDescription: useDocCommentAsDescription,
    );
  }
}
