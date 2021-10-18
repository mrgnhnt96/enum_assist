// ignore_for_file: comment_references, directives_ordering
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:enum_assist_annotation/src/extension_value.dart';

/// {@template enum_assist.additional_method}
/// helper class to create additional methods
/// {@endtemplate}
abstract class AdditionalExtension<T, V extends ExtensionValue<T>> {
  /// {@macro enum_assist.additional_method}
  const AdditionalExtension({
    this.defaultValue,
    required this.methodName,
    required this.methodType,
    required this.docComment,
    required this.allowNulls,
  });

  /// {@template enum_assist.additional_extension.default_value}
  /// The method name to be used in the generated code.
  /// {@endtemplate}
  final String methodName;

  /// {@template enum_assist.additional_extension.default_value}
  /// The default value to be used if an enum value is not specified.
  /// {@endtemplate}
  final T? defaultValue;

  /// {@macro enum_assist.method_type}
  final MethodType methodType;

  /// {@template enum_assist.additional_extension.doc_comment}
  /// The doc comment to be used in the generated code.
  ///
  /// the `///` will be automatically added to the start of all new lines.
  /// {@endtemplate}
  final String? docComment;

  /// {@template enum_assist.additional_extension.allow_nulls}
  /// When the value of the extension can return null
  ///
  /// _default: false_
  /// {@endtemplate}
  final bool allowNulls;
}
