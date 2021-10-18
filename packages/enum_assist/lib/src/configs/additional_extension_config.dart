import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist/src/util/util.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.additional_extension_config}
/// The configuration for the additional extension.
/// {@endtemplate}
class AdditionalExtensionConfig {
  /// {@macro enum_assist.additional_extension_config}
  AdditionalExtensionConfig._(
      {required String methodName,
      required this.methodType,
      required this.valueType,
      required this.defaultValue,
      required this.className,
      required this.valueClassType,
      required this.docComment,
      required this.allowNulls})
      : methodName = methodName.toCamelCase();

  ///
  final String valueType;

  ///
  final String methodName;

  ///
  final MethodType methodType;

  ///
  final String? defaultValue;

  /// name of the class used to create the extension
  final String className;

  /// type of class used to create the value
  final String valueClassType;

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

  /// used for testing
  ///
  /// {@macro enum_assist.additional_extension_config}
  @visibleForTesting
  static AdditionalExtensionConfig manual({
    String methodName = 'manual',
    MethodType methodType = MethodType.map,
    String? defaultValue,
    String className = 'Manual',
    String valueClassType = 'MyValue',
    String valueType = 'String',
    String? docComment,
    bool allowNulls = false,
  }) {
    return AdditionalExtensionConfig._(
      valueType: valueType,
      methodType: methodType,
      methodName: methodName,
      defaultValue: defaultValue,
      className: className,
      valueClassType: valueClassType,
      docComment: docComment,
      allowNulls: allowNulls,
    );
  }

  /// resolve the [AdditionalExtensionConfig] from a `ConstantReader`
  static AdditionalExtensionConfig? resolve(
      ClassElement element, ConstantReader reader) {
    final details = '${reader.objectValue}';

    final extensionClassName = RegExp(r'^(\w+)').firstMatch(details)!.group(0)!;

    final methodNameValue = reader.peek('methodName')?.stringValue;
    final methodTypeObj = reader.peek('methodType')?.objectValue;
    final defaultValue = '$extensionClassName().defaultValue';
    final docCommentValue = reader.peek('docComment')?.stringValue;
    final allowNullsValue = reader.peek('allowNulls')?.boolValue;
    final methodTypeValue =
        getEnumFromDartObject(methodTypeObj, MethodType.values);

    const comparable = 'AdditionalExtension<';
    final match =
        RegExp('$comparable([^>]*[, ]?)').firstMatch(details)?.group(0);

    final typeArguments = match?.substring(comparable.length).split(', ');

    final valueType = typeArguments?[0];
    final valueClassType = typeArguments?[1];

    if (valueType == null ||
        valueClassType == null ||
        methodTypeValue == null ||
        methodNameValue == null) {
      throw 'missing values!';
    }

    final data = AdditionalExtensionConfig._(
      methodType: methodTypeValue,
      methodName: methodNameValue,
      valueType: valueType,
      defaultValue: methodTypeValue.map(map: null, maybeMap: defaultValue),
      className: extensionClassName,
      valueClassType: valueClassType,
      docComment: docCommentValue,
      allowNulls: allowNullsValue ?? false,
    );

    return data;
  }

  @override
  String toString() {
    return '''
valueType: $valueType
methodName: $methodName
methodType: $methodType
defaultValue: $defaultValue
className: $className
valueClassType: $valueClassType
docComment: $docComment
''';
  }
}
