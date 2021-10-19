import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.additional_extension_value}
/// helper class to create the value for an additional extension
/// {@endtemplate}
abstract class Extension<T extends Object?> {
  /// {@macro enum_assist.additional_extension_value}
  const Extension(
    this.value, {
    this.defaultValue,
    required this.methodName,
    this.methodType = MethodType.maybeMap,
    this.docComment,
    this.allowNulls = true,
  });

  /// the value to be used in the generated code
  final T value;

  /// the name of the method
  ///
  /// must match spelling of `MapExtension.methodName`
  /// or `MaybeMapExtension.methodName`
  final String methodName;

  /// {@template enum_assist.additional_extension.default_value}
  /// The default value to be used if an enum value is not specified.
  ///
  /// _default: null_
  /// {@endtemplate}
  final T? defaultValue;

  /// {@macro enum_assist.method_type}
  ///
  /// _default: `MethodType.maybeMap`
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

///
abstract class MaybeExtension<T extends Object?> extends Extension<T> {
  ///
  const MaybeExtension(
    T value, {
    required String methodName,
    required T defaultValue,
    String? docComment,
    bool allowNulls = false,
  }) : super(
          value,
          methodName: methodName,
          defaultValue: defaultValue,
          methodType: MethodType.maybeMap,
          docComment: docComment,
          allowNulls: allowNulls,
        );
}

///
abstract class MapExtension<T extends Object?> extends Extension<T> {
  ///
  const MapExtension(
    T value, {
    required String methodName,
    String? docComment,
    bool allowNulls = false,
  }) : super(
          value,
          methodName: methodName,
          defaultValue: null,
          methodType: MethodType.map,
          docComment: docComment,
          allowNulls: allowNulls,
        );
}
