import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/configs/extension_config.dart';
import 'package:enum_assist/src/util/extensions.dart';
import 'package:enum_assist/src/util/util.dart';
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
    required this.intValue,
    required this.index,
    required this.fieldName,
    required this.readableName,
    required this.serializedValue,
    required this.serializedValueIsString,
    required this.useDocCommentAsDescription,
    required this.extensions,
    required this.serializedFormat,
  });

  /// {@macro enum_assist.enum_field}
  ///
  /// Retrieves data from the annotation & merges it with [classConfig]
  factory FieldData.config(
      FieldElement element, ClassConfig classConfig, int index) {
    final extensions = ExtensionConfig.resolve(element);

    final object = enumKeyChecker.getObjectFromAnnotation(element);
    final reader = ConstantReader(object);

    final readable = reader.peek('readable')?.stringValue;

    final description = reader.peek('description')?.stringValue;

    final intValue = reader.peek('intValue')?.intValue;

    final serializedReader = reader.peek('serializedValue');

    Object? serializedValue;
    final serializedValueIsNull = serializedReader?.isNull ?? true;
    final serializedValueIsString = serializedReader?.isString ?? false;

    if (!serializedValueIsNull) {
      serializedReader!; // set to non-null

      if (serializedReader.isString || serializedReader.isInt) {
        serializedValue = serializedReader.literalValue;
      } else {
        final enumAndField =
            '${element.getter?.declaration}'.replaceAll(' get ', '.');

        throw EnumException(
          error: 'Invalid Serialized Value Type',
          where: enumAndField,
          what: '"$enumAndField" has been assigned an '
              'invalid type for the field `serializedValue`',
          rule: '`serializedValue` can be types '
              '`String` and `int`',
          fix: 'Change the value in "$enumAndField" for the '
              '`serializedValue` field',
        );
      }

      // the following works, but i don't think that we should allow all types
      // to be serialized.
      // I think that we should just allow String, int, double, num, int
      /*
      final details = '${reader.read('serializedValue').objectValue}';

      // checks if the value is not a literal
      final pattern = RegExp(r'\w+ \(\w+ = ');
      if (details.contains(pattern)) {
        var annotation = element.getEnumKeyAnnotation()?.toSource();
        if (annotation != null) {
          annotation =
              annotation.substring('@EnumKey('.length, annotation.length - 1);

          // splits the arguments by ": "
          final namedArgPattern = RegExp(r'(\w+): (?![^(]*\))');
          final matches = namedArgPattern.allMatches(annotation);

          const comparable = 'serializedValue: ';

          int? start, end;
          for (final match in matches) {
            final str = match.group(0);

            if (str == comparable) {
              start = match.end;
            } else if (start != null) {
              end = match.start;
              break;
            }
          }

          if (start != null) {
            serializedValue =
                annotation.substring(start, end ?? annotation.length).trim();

            if (serializedValue.endsWith(',')) {
              serializedValue =
                  serializedValue.substring(0, serializedValue.length - 1);
            }
          }
        }
      } else {
        serializedValue =
            details.substring(details.indexOf('(') + 1, details.indexOf(')'));

        serializedValueIsString = details.split(' ').first == 'String';
      }
          */
    }

    final useDocCommentAsDescription =
        reader.peek('useDocCommentAsDescription')?.boolValue;

    final data = FieldData(
      enumName: classConfig.enumName,
      docComment: element.documentationComment,
      description: description,
      intValue: intValue,
      index: index,
      fieldName: element.name,
      readableName: readable,
      serializedValue: serializedValue,
      serializedValueIsString: serializedValueIsString,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? classConfig.useDocCommentAsDescription,
      extensions: extensions,
      serializedFormat: classConfig.serializedFormat,
    );

    return data;
  }

  /// [EnumKey.readable]
  final String? readableName;

  /// Doc comment of the field
  final String? docComment;

  /// [EnumKey.description]
  final String? description;

  /// [EnumKey.intValue]
  final int? intValue;

  /// The index of the field in the enum
  final int index;

  /// The name of the enum
  final String enumName;

  /// [EnumKey.extensions]
  final Map<String, ExtensionConfig> extensions;

  /// The name of the field
  final String fieldName;

  /// [EnumKey.serializedValue]
  final Object? serializedValue;

  /// [EnumKey.useDocCommentAsDescription]
  final bool useDocCommentAsDescription;

  /// [EnumAssist.serializedFormat]
  final SerializedFormat serializedFormat;

  /// Whether the [serializedValue] is a string
  final bool serializedValueIsString;

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

  /// [EnumKey.readable]
  ///
  /// _prioritizes by order:_
  /// [readableName]
  /// [fieldName]
  ///
  /// [fieldName] is formatted to capital case
  String get getReadable {
    if (readableName != null) return readableName!;

    return fieldName.toCapitalCase();
  }

  /// [EnumKey.serializedValue]
  ///
  /// _prioritizes by order:_
  /// [serializedValue]
  /// [fieldName]
  ///
  /// [fieldName] is formatted by [EnumAssist.serializedFormat]
  String get getSerializedValue {
    if (serializedValue != null) {
      if (serializedValueIsString) {
        return "'$serializedValue'";
      }

      return '$serializedValue';
    }

    return "'${_format(fieldName)}'";
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
    String? readableName,
    String? docComment,
    String? description,
    int? intValue,
    int? index,
    String? enumName,
    Map<String, ExtensionConfig>? extensions,
    String? fieldName,
    Object? serializedValue,
    bool? serializedValueIsString,
    bool? useDocCommentAsDescription,
    SerializedFormat? serializedFormat,
  }) {
    return FieldData(
      readableName: readableName ?? this.readableName,
      docComment: docComment ?? this.docComment,
      description: description ?? this.description,
      intValue: intValue ?? this.intValue,
      index: index ?? this.index,
      enumName: enumName ?? this.enumName,
      extensions: extensions ?? this.extensions,
      fieldName: fieldName ?? this.fieldName,
      serializedValue: serializedValue ?? this.serializedValue,
      serializedValueIsString:
          serializedValueIsString ?? this.serializedValueIsString,
      useDocCommentAsDescription:
          useDocCommentAsDescription ?? this.useDocCommentAsDescription,
      serializedFormat: serializedFormat ?? this.serializedFormat,
    );
  }

  @override
  String toString() => fieldName;
}
