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

const _reservedWords = {
  // dart specific
  'continue': '',
  'false': '',
  'new': '',
  'this': '',
  'default': '',
  'final': '',
  'null': '',
  'throw': '',
  'assert': '',
  'finally': '',
  'true': '',
  'do': '',
  'for': '',
  'try': '',
  'rethrow': '',
  'else': '',
  'if': '',
  'return': '',
  'var': '',
  'break': '',
  'enum': '',
  'void': '',
  'case': '',
  'while': '',
  'catch': '',
  'in': '',
  'super': '',
  'with': '',
  'class': '',
  'extends': '',
  'is': '',
  'switch': '',
  'const': '',
  'bool': '',
  'double': '',
  'dynamic': '',
  'int': '',
  'num': '',
  // enum_assist specific
  'map': '',
  'maybeMap': '',
  'name': '',
  'description': '',
  'serialized': '',
};

/// {@template enum_assist.extension_value_config}
/// The configuration for the additional extension.
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

  /// The name of the class that represents the value.
  final String methodName;

  /// The name of the top level class in the [EnumKey] annotation
  final String valueClassName;

  /// The type of the value.
  final String valueType;

  /// The value.
  final String value;

  ///
  final MethodType methodType;

  ///
  final String? defaultValue;

  /// {@macro enum_assist.additional_extension.doc_comment}
  final String? docComment;

  /// {@macro enum_assist.additional_extension.allow_nulls}
  final bool allowNulls;

  /// returns the formatted [docComment]
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

  /// retrieves Map<METHOD_NAME, ExtensionConfig> from the [element]
  static Map<String, ExtensionConfig> resolve(FieldElement element) {
    final object = FieldData.enumKeyChecker.getObjectFromAnnotation(element);
    final reader = ConstantReader(object);

    final enumAndField =
        '${element.getter?.declaration}'.replaceAll(' get ', '.');

    List<String> getDetailedExtension(ElementAnnotation data) {
      const comparable = 'List<Extension<Object>> ([';

      final detailsRaw = '${reader.peek('extensions')?.objectValue}';

      if (!detailsRaw.contains(comparable)) return [];

      final details =
          detailsRaw.substring(comparable.length, detailsRaw.length - 2);

      return details.split(', ');
    }

    List<String> getExtension(String str) {
      if (str.isEmpty) return [];

      final bracket = matchBracket(str, '(', 0);
      if (bracket == null) return [];

      final extClass = str.substring(0, bracket.start);
      final annotation = '$extClass(${bracket.contents})';
      final remaining = str.substring(min(bracket.end + 3, str.length));

      if (remaining.isEmpty) return [annotation];

      final ext = getExtension(remaining);

      return [annotation, ...ext];
    }

    List<String> getExtensionAnnotation(ElementAnnotation data) {
      const comparable = 'extensions: [';
      const length = comparable.length;

      final detailsRaw = data.toSource();

      if (!detailsRaw.contains(comparable)) return [];

      var details =
          detailsRaw.substring(detailsRaw.indexOf(comparable) + length);

      details = details.substring(0, details.lastIndexOf(']'));

      final extensions = getExtension(details);

      return extensions;
    }

    String checkMethodNameForReservedWords(String methodName) {
      if (_reservedWords.containsKey(methodName)) {
        final replacement = '${methodName}Ext';
        GeneratorHelper.addToWarnings(
          warning: 'Reserved Word in Method Name',
          where: enumAndField,
          what: 'The method name "$methodName" is a reserved word '
              'and it cannot be used as a method name',
          action: '"$methodName" will be RENAMED to "$replacement"',
        );
        return replacement;
      }

      return methodName;
    }

    Map<String, ExtensionConfig> getClassesAndValues(
        List<String> annotations, List<String> details) {
      final configs = <String, ExtensionConfig>{};

      /// Map<CLASS_NAME, METHOD_NAME>
      final classToMethod = <String, String>{};

      void checkIfMethodNameIsUniqueToClass(
        String className,
        String methodName,
      ) {
        void checkIfMethodNameIsUnique() {
          if (!classToMethod.containsValue(methodName)) {
            classToMethod[className] = methodName;
            return;
          }

          final classes = classToMethod.entries
              .where((entry) => entry.value == methodName)
              .map((entry) => entry.key)
              .toList();

          if (classes.length == 1) return;

          final classesInError = classes.join(' & ');

          throw EnumException(
            error: 'Duplicated Method Name',
            where: enumAndField,
            what: 'The method "$methodName" has been '
                'defined in $classesInError',
            rule: 'Method names must be unique.',
            fix: 'Double Check $classesInError, and change one of the '
                'method names from "$methodName" and try again',
          );
        }

        // if class doesn't exist, add it and move on
        if (!classToMethod.containsKey(className)) {
          classToMethod[className] = methodName;

          checkIfMethodNameIsUnique();
          return;
        }

        // get method name and check that is matches [methodName]
        final existingMethodName = classToMethod[className];
        if (existingMethodName == methodName) return;

        // [methodName] did not match [existingMethodName]
        throw EnumException(
          error: 'Duplicated Method Name',
          where: enumAndField,
          what: '$className has different method names assigned, '
              '"$existingMethodName" and "$methodName" were found',
          rule: 'Method names must be unique for each `enum`',
          fix: 'Double Check $className, and change one of the '
              'method names from "$methodName" or $existingMethodName '
              'and try again',
        );
      }

      // Map<TOP_LEVEL_NAME, VALUE>
      final topLevel = <String, String>{};

      /// does nothing if key is not found
      ///
      /// throws error if key is found,
      /// all methodNames must be unique
      void checkIfExtClassExists(String extClassName) {
        if (!topLevel.containsKey(extClassName)) return;

        throw EnumException(
          error: 'Duplicated Extension Declaration',
          where: enumAndField,
          what: 'The extension "$extClassName" has been '
              'declared already for $enumAndField',
          rule: 'Extensions can only be declared '
              'once for a single enum field',
          fix: 'Double check the argument '
              '`extensions: [...]` in $enumAndField '
              '& change or remove a `$extClassName` declaration',
        );
      }

      for (final extClass in annotations) {
        final parenthesisPosition = extClass.indexOf('(');

        // skip extensions with an empty list
        if (parenthesisPosition == -1) continue;

        final name = extClass.substring(0, parenthesisPosition);
        checkIfExtClassExists(name);

        var value = extClass.substring(
          parenthesisPosition + 1,
          extClass.length - 1,
        );

        if (value == '') {
          topLevel[name] = 'null';
          continue;
        }

        // splits the arguments by ": "
        final namedArgPattern = RegExp(r'(\w+: )(?![^(]*\))');
        if (namedArgPattern.hasMatch(value)) {
          // can't really know exactly where the value is,
          // so just assume its the first one...
          final args = value.split(namedArgPattern)
            ..removeWhere((e) => e.isEmpty);

          value = args[0];
        }

        topLevel[name] = value;
      }

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

        var value = topLevel[extensionClassName];
        final isValueNull = value == 'null';
        final isFallbackValueNull = fallbackValue?.isNull ?? true;

        if (isValueNull && !isFallbackValueNull) {
          value = '$extensionClassName().value';
        }

        // should never throw, as all fields are required
        // non-nullable fields
        //
        // but just in case (also helps with null safety!)
        if (methodName == null ||
            methodType == null ||
            allowNulls == null ||
            value == null) {
          final missingFields = <String>[];

          if (methodName == null) missingFields.add('methodName');
          if (methodType == null) missingFields.add('methodType');
          if (allowNulls == null) missingFields.add('allowNulls');
          if (value == null) missingFields.add('value');

          final whatsMissing = missingFields.join(', ');

          throw EnumException(
            error: 'Missing Required Fields',
            where: enumAndField,
            rule: 'All methods must have a method name [methodName], '
                'method type, a value, and whether `null`s may '
                'be a return value [allowNulls]',
            what: 'The extension "$extensionClassName" is missing '
                'the following fields: $whatsMissing',
            fix: 'Double check $extensionClassName, found in the argument '
                "`extensions: [...]` from $enumAndField's annotation. "
                'Make sure that the fields: $whatsMissing, '
                'are properly assigned',
          );
        }

        checkIfMethodNameIsUniqueToClass(extensionClassName, methodName);

        methodName = checkMethodNameForReservedWords(methodName);
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

    final extensionsMap = <String, ExtensionConfig>{};

    for (final data in element.metadata) {
      final annotation = getExtensionAnnotation(data);
      final details = getDetailedExtension(data);

      extensionsMap.addAll(getClassesAndValues(annotation, details));
    }

    return extensionsMap;
  }
}
