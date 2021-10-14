import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/configs.dart';
import 'package:enum_assist/src/configs/extension_value_config.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.key_config}
/// Represents values from the [EnumKey] annotation.
/// {@endtemplate}
class KeyConfig {
  /// {@macro enum_assist.key_config}
  const KeyConfig({
    required this.description,
    required this.name,
    required this.serializedValue,
    required this.useDocCommentAsDescription,
    required this.extensionValues,
  });

  /// {@macro enum_assist.key_config}
  KeyConfig.fromSettings(KeyConfig settings)
      : this(
          description: settings.description,
          name: settings.name,
          serializedValue: settings.serializedValue,
          useDocCommentAsDescription: settings.useDocCommentAsDescription,
          extensionValues: settings.extensionValues,
        );

  /// Constructs the key configs from the [EnumKey] annotation.
  /// and the class annotation [ClassConfig].
  ///
  /// {@macro enum_assist.key_config}
  factory KeyConfig.mergeConfigs(
    ClassConfig classConfig,
    FieldElement element,
  ) {
    const nameKey = 'name';
    const descriptionKey = 'description';
    const serializedValueKey = 'serializedValue';
    const useDocCommentAsDescriptionKey = 'useDocCommentAsDescription';
    const extensionValuesKey = 'extensionValues';

    DartObject? object;
    object = _enumKeyChecker.firstAnnotationOf(element);

    if (object == null) {
      if (element.getter != null) {
        object = _enumKeyChecker.firstAnnotationOf(element.getter!);
      }
    }

    if (object == null) {
      return defaults.copyWith(
        useDocCommentAsDescription: classConfig.useDocCommentAsDescription,
      );
    }
    final reader = ConstantReader(object);

    final name = reader.peek(nameKey)?.stringValue;

    final description = reader.peek(descriptionKey)?.stringValue;

    final serializedValue = reader.peek(serializedValueKey)?.stringValue;

    final useDocCommentAsDescription =
        reader.peek(useDocCommentAsDescriptionKey)?.boolValue;

    final extensionValuesRaw = reader.peek(extensionValuesKey)?.listValue;

    final extensionValues = <ExtensionValueConfig>[];

    if (extensionValuesRaw != null) {
      for (final entry in extensionValuesRaw) {
        final reader = ConstantReader(entry);
        final config = ExtensionValueConfig.resolve(reader);
        extensionValues.add(config);
      }
    }

    print(
        'class config uses doc comments? ${classConfig.useDocCommentAsDescription}');
    return KeyConfig(
      name: name,
      description: description,
      serializedValue: serializedValue,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? classConfig.useDocCommentAsDescription,
      extensionValues: extensionValues,
    );
  }

  /// {@macro enum_assist_annotation.enum_key.description}
  final String? description;

  /// {@macro enum_assist_annotation.enum_key.name}
  final String? name;

  /// {@macro enum_assist_annotation.enum_key.serialized_value}
  final String? serializedValue;

  /// {@macro enum_assist_annotation.enum_key.use_doc_comment_as_description}
  final bool useDocCommentAsDescription;

  /// {@macro enum_assist_annotation.enum_key.extension_values}
  final List<ExtensionValueConfig> extensionValues;

  /// all the default values of [EnumKey]
  static const defaults = KeyConfig(
    name: null,
    description: null,
    serializedValue: null,
    useDocCommentAsDescription: true,
    extensionValues: [],
  );

  static const _enumKeyChecker = TypeChecker.fromRuntime(EnumKey);

  /// @nodoc
  KeyConfig copyWith({
    String? description,
    String? name,
    String? serializedValue,
    bool? useDocCommentAsDescription,
    List<ExtensionValueConfig>? extensionValues,
  }) {
    return KeyConfig(
      description: description ?? this.description,
      name: name ?? this.name,
      serializedValue: serializedValue ?? this.serializedValue,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? this.useDocCommentAsDescription,
      extensionValues: extensionValues ?? this.extensionValues,
    );
  }
}
