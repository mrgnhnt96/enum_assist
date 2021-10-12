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
  factory EnumField.config(FieldElement e, ClassConfig con) => EnumField._(
        e.type.element!.name!,
        e.name,
        fieldFormat: con.fieldFormat,
        docComment: e.documentationComment,
        config: KeyConfig.mergeConfigs(con, e),
      );

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
      return docComment
          ?.replaceAll(RegExp(r'///(?:[\s]*)'), '')
          .replaceAll(RegExp(r'\n'), ' ');
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

    return _format(fieldName, _AllFormats.title);
  }

  @override
  String toString() => fieldName;

  String _format(String s, [_AllFormats? format]) {
    if (format != null) return format.format(s);

    return fieldFormat.map(
      kebab: s.kebab,
      snake: s.snake,
      pascal: s.pascal,
      none: s,
    );
  }
}

enum _AllFormats { title, kebab, snake, pascal, none }

extension on _AllFormats {
  T map<T>({
    required T title,
    required T kebab,
    required T snake,
    required T pascal,
    required T none,
  }) {
    switch (this) {
      case _AllFormats.title:
        return title;
      case _AllFormats.kebab:
        return kebab;
      case _AllFormats.snake:
        return snake;
      case _AllFormats.pascal:
        return pascal;
      case _AllFormats.none:
        return none;
    }
  }

  String format(String s) {
    return map(
      title: s.title,
      kebab: s.kebab,
      snake: s.snake,
      pascal: s.pascal,
      none: s,
    );
  }
}

extension on String {
  String get title {
    String capitalizeFirstLetter(String word) {
      final firstLetter = word.substring(0, 1).toUpperCase();
      final rest = word.substring(1).toLowerCase();
      final capitalizedWord = '$firstLetter$rest';

      return capitalizedWord;
    }

    final words = snake.split('_');

    return words.map(capitalizeFirstLetter).join(' ');
  }
}
