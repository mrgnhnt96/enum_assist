import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:enum_assist_annotation/src/additional_extension.dart';
import 'package:enum_assist_annotation/src/extension_value.dart';

/// {@template enum_assist.map_additional_extension}
/// helper class to create a new extension with a map method
///
/// `MapExtension<T, V>` must be on the __highest
/// level__ of the class hierarchy
/// {@endtemplate}
abstract class MapExtension<T extends Object?, V extends ExtensionValue<T>>
    extends AdditionalExtension<T, V> {
  /// {@macro enum_assist.map_additional_extension}
  const MapExtension(
    String methodName, {
    String? docComment,
    bool allowNulls = false,
  }) : super(
          methodName: methodName,
          methodType: MethodType.map,
          docComment: docComment,
          allowNulls: allowNulls,
        );
}
