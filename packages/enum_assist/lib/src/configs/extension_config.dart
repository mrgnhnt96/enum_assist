import 'dart:math';

import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/generator_helpers/generator_helpers.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist/src/util/exceptions.dart';
import 'package:enum_assist/src/util/extensions.dart';
import 'package:enum_assist/src/util/match_bracket.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

part 'extension_config_helper.dart';

/// {@template enum_assist.extension_value_config}
/// The configuration for an [Extension]
/// {@endtemplate}
class ExtensionConfig {
  /// {@macro enum_assist.extension_value_config}
  ExtensionConfig({
    required String methodName,
    required this.valueClassName,
    required this.valueType,
    required this.value,
    required this.methodType,
    required this.defaultValue,
    required this.docComment,
    required this.allowNulls,
  }) : methodName = methodName.toCamelCase();

  /// for testing purposes only
  @visibleForTesting
  ExtensionConfig.manual({
    String methodName = '',
    this.valueClassName = '',
    this.valueType = '',
    this.value = '',
    this.methodType = MethodType.map,
    this.defaultValue,
    this.docComment,
    this.allowNulls = true,
  }) : methodName = methodName.toCamelCase();

  /// [Extension.methodName]
  final String methodName;

  /// The class used to define the [Extension]
  final String valueClassName;

  /// The type of [Extension.value]
  final String valueType;

  /// [Extension.value]
  final String value;

  /// [Extension.methodType]
  final MethodType methodType;

  /// [Extension.defaultValue]
  final String? defaultValue;

  /// [Extension.docComment]
  final String? docComment;

  /// [Extension.allowNulls]
  final bool allowNulls;

  /// [Extension.docComment]
  ///
  /// If [docComment] is `null`, returns `/// @nodoc`\
  /// Prepends `/// ` to each line of [docComment]
  String getDocComment() {
    if (docComment == null) return '/// @nodoc';

    return docComment!
        // prepend "/// " to each line that starts with anything other than a line break
        .replaceAllMapped(
            RegExp('^(.)', multiLine: true), (match) => '/// ${match.group(0)}')

        /// prepend "/// " to each line that starts with a line break
        .replaceAllMapped(RegExp(r'^\n', multiLine: true), (_) => '///\n');
  }

  @override
  String toString() {
    return '''
methodName: $methodName
valueClassName: $valueClassName
valueType: $valueType
value: $value
''';
  }

  /// {@macro enum_assist.extension_value_config}
  ///
  /// Returns Map<[methodName], [ExtensionConfig]> from the [element]
  static Map<String, ExtensionConfig> resolve(FieldElement element) {
    final object = FieldData.enumValueChecker.getObjectFromAnnotation(element);
    final reader = ConstantReader(object);

    final enumAndField =
        '${element.getter?.declaration}'.replaceAll(' get ', '.');

    Map<String, ExtensionConfig> getConfiguration(List<String> annotations) {
      final configs = <String, ExtensionConfig>{};

      /// Map<[ExtensionConfig.valueClassName], [ExtensionConfig.methodName]>
      final classToMethod = <String, String>{};

      /// Map<[ExtensionConfig.valueClassName], [ExtensionConfig.value]>
      final extensionDeclarations = _checkForDuplicateDeclarations(
        annotations,
        enumAndField,
      );

      final extensions = reader.peek('extensions')?.listValue;

      if (extensions == null) return configs;

      for (final entry in extensions) {
        final extension = ConstantReader(entry);
        final details = '${extension.objectValue}';

        const extensionStr = 'Extension<';

        if (!details.contains(extensionStr)) continue;

        var valueType = details.substring(
          details.indexOf(extensionStr) + extensionStr.length,
        );

        valueType = valueType.substring(0, valueType.indexOf('> ('));

        final extensionClassName =
            RegExp(r'^(\w+)').firstMatch(details)!.group(0)!;

        var methodName =
            extension.peek('methodName')?.stringValue.toCamelCase();

        final defaultAccess = annotations.firstWhere(
            (element) => element.startsWith(extensionClassName), orElse: () {
          throw Exception('No default accessor found for $extensionClassName');
        });

        final defaultValue = '$defaultAccess.defaultValue';
        final docComment = extension.peek('docComment')?.stringValue;
        final allowNulls = extension.peek('allowNulls')?.boolValue;
        final methodTypeObj = extension.peek('methodType')?.objectValue;
        final methodType =
            getEnumFromDartObject(methodTypeObj, MethodType.values);
        final fallbackValue = extension.peek('value')?.objectValue;

        var value = extensionDeclarations[extensionClassName];
        final isValueNull = value == 'null';
        final isFallbackValueNull = fallbackValue?.isNull ?? true;

        if (isValueNull && !isFallbackValueNull) {
          value = '$extensionClassName().value';
        }

        // if missing value, throw error
        _throwIfMissingField(
          value: value,
          methodName: methodName,
          methodType: methodType,
          allowNulls: allowNulls,
          enumAndField: enumAndField,
          extensionClassName: extensionClassName,
        );

        // Force non null values
        methodName!;
        value!;
        methodType!;
        allowNulls!;

        // make sure we aren't returnning a null value
        // when the return type cannot be null
        //
        // applies to [MethodType.map]
        _throwIfNullValueOnNonNullReturn(
          value: value,
          allowNulls: allowNulls,
          methodType: methodType,
          enumAndField: enumAndField,
          extensionClassName: extensionClassName,
        );

        // make sure [methodName] is not duplicated
        // between extension class declarations
        _checkIfMethodNameIsUniqueToClass(
          extensionClassName,
          methodName,
          classToMethod,
          enumAndField,
        );

        // check for reserved word and update if necessary
        methodName = _checkMethodNameForReservedWords(methodName, enumAndField);

        configs[methodName] = ExtensionConfig(
          methodName: methodName,
          valueClassName: extensionClassName,
          valueType: valueType,
          value: value,
          methodType: methodType,
          allowNulls: allowNulls,
          defaultValue: defaultValue,
          docComment: docComment,
        );
      }

      return configs;
    }

    final configs = <String, ExtensionConfig>{};

    final data = element.getEnumValueAnnotation();

    if (data != null) {
      final annotation = _getExtensionAnnotation(data);

      configs.addAll(getConfiguration(annotation));
    }

    return configs;
  }
}
