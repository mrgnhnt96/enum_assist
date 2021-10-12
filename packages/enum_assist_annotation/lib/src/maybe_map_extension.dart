import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:enum_assist_annotation/src/additional_extension.dart';
import 'package:enum_assist_annotation/src/extension_value.dart';

/// {@template enum_assist.maybe_map_additional_extension}
/// helper class to create a new extension with a maybeMap method
/// {@endtemplate}
abstract class MaybeMapExtension<T, V extends ExtensionValue<T>>
    extends AdditionalExtension<T, V> {
  /// {@macro enum_assist.maybe_map_additional_extension}
  const MaybeMapExtension(
    String methodName, {
    required T defaultValue,
  }) : super(
          defaultValue: defaultValue,
          methodName: methodName,
          methodType: MethodType.maybeMap,
        );
}
