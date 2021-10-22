import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:enum_assist/src/util/extensions.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.enum_field}
/// An enum field with all the information needed to generate the code.
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
  ///
  /// Retrieves data from the annotation & merges it with [classConfig]
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

  /// [EnumKey.name]
  final String? assignedName;

  /// Doc comment of the field
  final String? docComment;

  /// [EnumKey.description]
  final String? description;

  /// The name of the enum
  final String enumName;

  /// [EnumKey.extensions]
  final Map<String, ExtensionConfig> extensions;

  /// The name of the field
  final String fieldName;

  /// [EnumKey.serializedValue]
  final String? serializedValue;

  /// [EnumKey.useDocCommentAsDescription]
  final bool useDocCommentAsDescription;

  /// [EnumAssist.serializedFormat]
  final SerializedFormat serializedFormat;

  // -- getters --

  /// Gets then [ExtensionConfig] from [methodName]
  ExtensionConfig? getExtension(String methodName) {
    if (extensions.isEmpty) return null;

    return extensions[methodName];
  }

  /// [EnumKey.description]
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

  /// [EnumKey.name]
  ///
  /// _prioritizes by order:_
  /// [assignedName]
  /// [fieldName]
  ///
  /// [fieldName] is formatted to capital case
  String get getName {
    if (assignedName != null) return assignedName!;

    return fieldName.toCapitalCase();
  }

  /// [EnumKey.serializedValue]
  ///
  /// _prioritizes by order:_
  /// [serializedValue]
  /// [fieldName]
  ///
  /// [fieldName] is formatted by [EnumAssist.serializedFormat]
  String get getSerializedName {
    if (serializedValue != null) return serializedValue!;

    return _format(fieldName);
  }

  /// [fieldName] as a private member
  String get privateName => '_${fieldName}Name';

  /// return the name of the enum & field as a string
  ///
  /// e.g. `MyEnum.myField`
  String get wholeName => '$enumName.$fieldName';

  /// type checker for [EnumKey]
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
