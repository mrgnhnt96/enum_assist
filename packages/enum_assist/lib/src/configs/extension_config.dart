import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist/src/util/extensions.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

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

  /// The name of the top level class in the `EnumKey` annotation
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

    List<String> getDetailedExtension(ElementAnnotation data) {
      const comparable = 'List<Extension<Object>> ([';

      final detailsRaw = '${reader.peek('extensions')?.objectValue}';

      if (!detailsRaw.contains(comparable)) return [];

      final details =
          detailsRaw.substring(comparable.length, detailsRaw.length - 2);

      return details.split(', ');
    }

    List<String> getExtensionAnnotation(ElementAnnotation data) {
      const comparable = 'extensions: [';
      const length = comparable.length;

      final detailsRaw = data.toSource();

      if (!detailsRaw.contains(comparable)) return [];

      var details =
          detailsRaw.substring(detailsRaw.indexOf(comparable) + length);

      details = details.substring(0, details.indexOf(']'));

      return details.split(', ');
    }

    /// returns Map<METHOD_NAME, List<0=TYPE, 1=VALUE>
    Map<String, ExtensionConfig> getClassesAndValues(
        List<String> annotations, List<String> details) {
      final values = <String, ExtensionConfig>{};

      // Map<TOP_LEVEL_NAME, VALUE>
      final topLevel = <String, String>{};
      for (final extClass in annotations) {
        final parenthesisPosition = extClass.indexOf('(');

        final name = extClass.substring(0, parenthesisPosition);
        var value =
            extClass.substring(parenthesisPosition + 1, extClass.length - 1);

        if (value == '') {
          value = 'null';
        }

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

      if (extensions != null) {
        for (final entry in extensions) {
          final extension = ConstantReader(entry);
          final details = '${extension.objectValue}';

          const extensionStr = 'Extension<';

          if (!details.contains(extensionStr)) continue;

          var valueType = details
              .substring(details.indexOf(extensionStr) + extensionStr.length);

          valueType = valueType.substring(0, valueType.indexOf('>'));

          final extensionClassName =
              RegExp(r'^(\w+)').firstMatch(details)!.group(0)!;
          final methodName =
              extension.peek('methodName')?.stringValue.toCamelCase();

          final defaultAccess = annotations.firstWhere(
              (element) => element.startsWith(extensionClassName), orElse: () {
            throw Exception(
                'No default accessor found for $extensionClassName');
          });

          final defaultValue = '$defaultAccess.defaultValue';
          final docComment = extension.peek('docComment')?.stringValue;
          final allowNulls = extension.peek('allowNulls')?.boolValue;
          final methodTypeObj = extension.peek('methodType')?.objectValue;
          final methodType =
              getEnumFromDartObject(methodTypeObj, MethodType.values);

          final value = topLevel[extensionClassName];

          if (methodName == null ||
              methodType == null ||
              allowNulls == null ||
              value == null) {
            throw 'missing values!';
          }

          values[methodName] = ExtensionConfig(
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
      }

      return values;
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
