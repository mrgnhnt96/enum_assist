import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist_annotation.extension.maybe}
/// {@macro enum_assist_annotation.extension}
///
/// {@macro enum_assist_annotation.method_type.maybe_map}
///
/// ---
/// ### Value (required)
/// {@macro enum_assist_annotation.extension.value}
///
/// ---
/// ### Method Name (required)
/// {@macro enum_assist_annotation.extension.method_name}
///
/// ---
/// ### Default Value (required)
/// {@macro enum_assist_annotation.extension.default_value}
///
/// ---
/// ### Doc Comment (optional)
/// {@macro enum_assist_annotation.extension.doc_comment}
///
/// ---
/// ### Allow Nulls (optional)
/// {@macro enum_assist_annotation.extension.allow_nulls}
///
/// ---
/// _example:_
/// ```dart
/// class ExampleExt extends MaybeExtension<String> {
///   const ExampleExt(String value) : super(
///     value,
///     methodName: 'example',
///     defaultValue: 'default',
///     docComment: 'Example Extension',
///     allowNulls: false,
///   );
/// }
/// ```
/// {@endtemplate}
abstract class MaybeExtension<T extends Object?> extends Extension<T> {
  /// {@macro enum_assist_annotation.extension.maybe}
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
