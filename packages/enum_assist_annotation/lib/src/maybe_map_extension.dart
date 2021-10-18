import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:enum_assist_annotation/src/additional_extension.dart';
import 'package:enum_assist_annotation/src/extension_value.dart';

/// {@template enum_assist.maybe_map_additional_extension}
/// helper class to create a new extension with a maybeMap method
///
/// `MaybeMapExtension<T, V>` must be on the __highest
/// level__ of the class hierarchy
/// {@endtemplate}
abstract class MaybeMapExtension<T extends Object?, V extends ExtensionValue<T>>
    extends AdditionalExtension<T, V> {
  /// {@macro enum_assist.maybe_map_additional_extension}
  const MaybeMapExtension(
    String methodName, {
    required T defaultValue,
    String? docComment,
    bool allowNulls = false,
  }) : super(
          defaultValue: defaultValue,
          methodName: methodName,
          methodType: MethodType.maybeMap,
          docComment: docComment,
          allowNulls: allowNulls,
        );
}
