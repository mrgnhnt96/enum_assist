import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist_annotation.extension}
/// ___IMPORTANT__: All properties (other than [value]) need to be defined
/// within the super constructor!_
///
/// Creates an extension method for the enum.
/// {@endtemplate}
///
/// ---
///
/// ---
/// ### Value
/// {@macro enum_assist_annotation.extension.value}
///
/// ---
/// ### Default Value
/// {@macro enum_assist_annotation.extension.default_value}
///
/// ---
/// ### Method Name
/// {@macro enum_assist_annotation.extension.method_name}
///
/// ---
/// ### Method Type
/// {@macro enum_assist_annotation.method_type}
///
/// ---
/// ### Doc Comment
/// {@macro enum_assist_annotation.extension.doc_comment}
///
/// ---
/// ### Allow Nulls
/// {@macro enum_assist_annotation.extension.allow_nulls}

abstract class Extension<T extends Object?> {
  /// {@macro enum_assist_annotation.extension}
  const Extension(
    this.value, {
    this.defaultValue,
    required this.methodName,
    this.methodType = MethodType.maybeMap,
    this.docComment,
    this.allowNulls = false,
  });

  /// {@template enum_assist_annotation.extension.value}
  /// The value to be returned by the extension method
  /// for this enum field
  ///
  /// ___The [value] is the ONLY argument to be passed
  /// through the constructor___
  /// - It is ___not recommended___ to use named arguments
  /// - Positioned arguments are supported
  /// {@endtemplate}
  final T value;

  /// {@template enum_assist_annotation.extension.method_name}
  /// The name of the method to be created
  ///
  /// During generation, the method name will be converted to camelCase
  /// {@endtemplate}
  final String methodName;

  /// {@template enum_assist_annotation.extension.default_value}
  /// The default value to be used if [EnumKey.extensions]\
  /// does not declare a value for this [Extension]
  /// {@endtemplate}
  final T? defaultValue;

  /// {@macro enum_assist_annotation.method_type}
  ///
  /// ---
  /// ### Map
  /// {@macro enum_assist_annotation.method_type.map}
  ///
  /// ---
  /// ### Maybe Map
  /// {@macro enum_assist_annotation.method_type.maybe_map}
  ///
  /// ---
  ///
  /// __default:__ `MethodType.maybeMap`
  final MethodType methodType;

  /// {@template enum_assist_annotation.extension.doc_comment}
  /// The doc comment for the method
  ///
  /// _multi-line strings are supported_
  ///
  /// During generation, `///` will be prepended to each new line
  ///
  /// __default:__ "/// @nodoc"
  /// {@endtemplate}
  final String? docComment;

  /// {@template enum_assist_annotation.extension.allow_nulls}
  /// If set to true, the method will be created with a nullable return type
  ///
  /// __default:__ `false`
  /// {@endtemplate}
  final bool allowNulls;
}
