import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:enum_assist_annotation/src/additional_extension.dart';
import 'package:enum_assist_annotation/src/extension_value.dart';

/// {@template enum_assist.map_additional_extension}
/// helper class to create a new extension with a map method
/// {@endtemplate}
abstract class MapExtension<T, V extends ExtensionValue<T>>
    extends AdditionalExtension<T, V> {
  /// {@macro enum_assist.map_additional_extension}
  const MapExtension(
    String methodName,
  ) : super(
          methodName: methodName,
          methodType: MethodType.map,
        );
}
