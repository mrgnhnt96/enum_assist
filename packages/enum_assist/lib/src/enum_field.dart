import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_value_config.dart';
import 'package:enum_assist/src/src.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';

/// {@template enum_assist.enum_field}
/// A field & all its associated metadata.
/// {@endtemplate}
class EnumField extends KeyConfig {
  /// {@macro enum_assist.enum_field}
  EnumField._(
    this.belongsToEnum,
    this.fieldName, {
    required this.serializedFormat,
    required this.docComment,
    required KeyConfig config,
  }) : super.fromSettings(config);

  /// {@macro enum_assist.enum_field}
  factory EnumField.config(FieldElement e, ClassConfig con) => EnumField._(
        e.type.element!.name!,
        e.name,
        serializedFormat: con.serializedFormat,
        docComment: e.documentationComment,
        config: KeyConfig.mergeConfigs(con, e),
      );

  /// used for testing
  @protected
  @visibleForTesting
  EnumField.manual({
    this.belongsToEnum = 'MyEnum',
    this.fieldName = 'myField',
    this.serializedFormat = SerializedFormat.none,
    this.docComment,
    KeyConfig config = KeyConfig.defaults,
  }) : super.fromSettings(config);

  /// the name of the enum without formatting
  final String fieldName;

  /// the documentation associated with this field
  final String? docComment;

  /// the name of the enum the field is in
  final String belongsToEnum;

  /// the name of the field as a private member
  String get privateName => '_${fieldName}Name';

  /// return the name of the enum & field as a string
  ///
  /// e.g. `MyEnum.myField`
  String get wholeName => '$belongsToEnum.$fieldName';

  /// {@macro enum_assist_annotation.serialized_format}
  final SerializedFormat serializedFormat;

  /// gets the serialized form of the field's name
  ///
  /// _prioritizes the [serializedValue]_
  String get getSerializedName {
    if (serializedValue != null) return serializedValue!;

    return _format(fieldName);
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
  /// _prioritizes name from [EnumKey]
  ///
  /// if name is not provided, returns the field name
  /// formatted to Title case
  String get getName {
    if (name != null) return name!;

    return fieldName.toTitleCase();
  }

  /// returns the config for the extension
  ExtensionValueConfig? getExtensionValue(String valueClassName) {
    if (extensionValues.isEmpty) return null;

    final index =
        extensionValues.indexWhere((e) => e.valueClassName == valueClassName);
    if (index == -1) return null;

    return extensionValues[index];
  }

  @override
  String toString() => fieldName;

  String _format(String s) {
    return serializedFormat.map(
      kebab: s.toKebabCase(),
      snake: s.toSnakeCase(),
      pascal: s.toPascalCase(),
      camel: s.toCamelCase(),
      title: s.toTitleCase(),
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
}
