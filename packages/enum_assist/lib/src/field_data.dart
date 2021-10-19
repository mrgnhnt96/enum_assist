import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:enum_assist/src/util/extensions.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.enum_field}
/// A field & all its associated metadata.
/// {@endtemplate}
class FieldData {
  /// {@macro enum_assist.enum_field}
  const FieldData({
    required this.enumName,
    required this.docComment,
    required this.description,
    required this.fieldName,
    required this.assignedName,
    required this.serializedValue,
    required this.useDocCommentAsDescription,
    required this.extensions,
    required this.serializedFormat,
  });

  /// {@macro enum_assist.enum_field}
  factory FieldData.config(FieldElement element, ClassConfig classConfig) {
    final extensions = ExtensionConfig.resolve(element);

    final object = enumKeyChecker.getObjectFromAnnotation(element);
    final reader = ConstantReader(object);

    final name = reader.peek('name')?.stringValue;

    final description = reader.peek('description')?.stringValue;

    final serializedValue = reader.peek('serializedValue')?.stringValue;

    final useDocCommentAsDescription =
        reader.peek('useDocCommentAsDescription')?.boolValue;

    final data = FieldData(
      enumName: classConfig.enumName,
      docComment: element.documentationComment,
      description: description,
      fieldName: element.name,
      assignedName: name,
      serializedValue: serializedValue,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? classConfig.useDocCommentAsDescription,
      extensions: extensions,
      serializedFormat: classConfig.serializedFormat,
    );

    return data;
  }

  /// {@macro enum_assist_annotation.enum_key.name}
  final String? assignedName;

  /// the documentation associated with this field
  final String? docComment;

  /// {@macro enum_assist_annotation.enum_key.description}
  final String? description;

  /// the name of the enum the field is in
  final String enumName;

  /// {@macro enum_assist_annotation.enum_key.extension_values}
  final Map<String, ExtensionConfig> extensions;

  /// {@macro enum_assist_annotation.enum_key.name}
  final String fieldName;

  /// {@macro enum_assist_annotation.enum_key.serialized_value}
  final String? serializedValue;

  /// {@macro enum_assist_annotation.enum_key.use_doc_comment_as_description}
  final bool useDocCommentAsDescription;

  /// {@macro enum_assist_annotation.serialized_format}
  final SerializedFormat serializedFormat;

  // -- getters --

  /// returns the config for the extension
  ExtensionConfig? getExtension(String methodName) {
    if (extensions.isEmpty) return null;

    return extensions[methodName];
  }

  /// get the description of the enum value
  ///
  /// _prioritizes by order:_
  /// - [description]
  /// - [docComment]
  String? get getDescription {
    if (description != null) return description;

    if (useDocCommentAsDescription) {
      return docComment?.replaceAll(RegExp('///(?: *)'), '');
    }

    return null;
  }

  /// retrieves the name
  ///
  /// _prioritizes name from [EnumKey]_
  ///
  /// if name is not provided, returns the field name
  /// formatted to Capital case
  String get getName {
    if (assignedName != null) return assignedName!;

    return fieldName.toCapitalCase();
  }

  /// gets the serialized form of the field's name
  ///
  /// _prioritizes the [serializedValue]_
  String get getSerializedName {
    if (serializedValue != null) return serializedValue!;

    return _format(fieldName);
  }

  /// the name of the field as a private member
  String get privateName => '_${fieldName}Name';

  /// return the name of the enum & field as a string
  ///
  /// e.g. `MyEnum.myField`
  String get wholeName => '$enumName.$fieldName';

  /// type checker used to retrieve annotation
  static const enumKeyChecker = TypeChecker.fromRuntime(EnumKey);

  String _format(String s) {
    return serializedFormat.map(
      kebab: s.toKebabCase(),
      snake: s.toSnakeCase(),
      pascal: s.toPascalCase(),
      camel: s.toCamelCase(),
      dot: s.toDotCase(),
      capital: s.toCapitalCase(),
      constant: s.toConstantCase(),
      header: s.toHeaderCase(),
      no: s.toNoCase(),
      path: s.toPathCase(),
      sentence: s.toSentenceCase(),
      swap: s.toSwapCase(),
      none: s,
    );
  }

  /// @nodoc
  FieldData copyWith({
    String? assignedName,
    String? docComment,
    String? description,
    String? enumName,
    Map<String, ExtensionConfig>? extensions,
    String? fieldName,
    String? serializedValue,
    bool? useDocCommentAsDescription,
    SerializedFormat? serializedFormat,
  }) {
    return FieldData(
      assignedName: assignedName ?? this.assignedName,
      docComment: docComment ?? this.docComment,
      description: description ?? this.description,
      enumName: enumName ?? this.enumName,
      extensions: extensions ?? this.extensions,
      fieldName: fieldName ?? this.fieldName,
      serializedValue: serializedValue ?? this.serializedValue,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? this.useDocCommentAsDescription,
      serializedFormat: serializedFormat ?? this.serializedFormat,
    );
  }

  @override
  String toString() => fieldName;
}
