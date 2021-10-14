import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/extension_template.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.additional_maybe_map_template}
/// helper class to create [MaybeMapTemplate]s
///
/// Uses the [map] method to access the enum value
/// {@endtemplate}
class MaybeMapTemplate extends ExtensionTemplate {
  /// {@macro enum_assist.additional_maybe_map_template}
  MaybeMapTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required String methodName,
    required String? Function(EnumField) getValue,
    required String? defaultValue,
    required String typeAsString,
    required String docComment,
  }) : super(
          enumName,
          fields,
          methodName: methodName,
          defaultValue: defaultValue,
          returnValue: getValue,
          methodType: MethodType.maybeMap,
          typeAsString: typeAsString,
          docComment: docComment,
        );
}
