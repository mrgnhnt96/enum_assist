import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist_annotation.extension.map}
/// {@macro enum_assist_annotation.extension}
///
/// {@macro enum_assist_annotation.method_type.map}
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
/// class ExampleExt extends MapExtension<String> {
///   const ExampleExt(String value) : super(
///     value,
///     methodName: 'example',
///     docComment: 'Example Extension',
///     allowNulls: false,
///   );
/// }
/// ```
/// {@endtemplate}
abstract class MapExtension<T extends Object?> extends Extension<T> {
  /// {@macro enum_assist_annotation.extension.map}
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
