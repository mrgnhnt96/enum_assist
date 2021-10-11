import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/src.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/src/case_helpers.dart'; // ignore: implementation_imports

/// {@template enum_assist.enum_field}
/// A field & all its associated metadata.
/// {@endtemplate}
class EnumField extends KeyConfig {
  /// {@macro enum_assist.enum_field}
  EnumField._(
    this.belongsToEnum,
    this.fieldName, {
    required this.fieldFormat,
    required this.docComment,
    required KeyConfig config,
  }) : super.fromSettings(config);

  /// {@macro enum_assist.enum_field}
  factory EnumField.config(FieldElement e, ClassConfig con) {
    return EnumField._(
      e.type.element!.name!,
      e.name,
      fieldFormat: con.fieldFormat,
      docComment: e.documentationComment,
      config: KeyConfig.mergeConfigs(con, e),
    );
  }

  /// used for testing
  @protected
  @visibleForTesting
  EnumField.manual({
    this.belongsToEnum = 'MyEnum',
    this.fieldName = 'myField',
    this.fieldFormat = FieldFormat.none,
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

  /// {@macro enum_assist_annotation.field_format}
  final FieldFormat fieldFormat;

  /// gets the serialized form of the field's name
  ///
  /// _prioritizes the [serializedValue]_
  String get getSerializedName {
    if (serializedValue != null) return serializedValue!;

    return fieldFormat.map(
      kebab: fieldName.kebab,
      snake: fieldName.snake,
      pascal: fieldName.pascal,
      none: fieldName,
    );
  }

  /// get the description of the enum value
  ///
  /// _prioritizes by order:_
  /// - [description]
  /// - [docComment]
  String? get getDescription {
    if (description != null) return description;
    if (useDocCommentAsDescription) return docComment;

    return null;
  }

  @override
  String toString() => fieldName;
}
