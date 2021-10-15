import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/extension_template.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// {@template enum_assist.additional_map_template}
/// helper class to create [MapTemplate]s
///
/// Uses the [map] method to access the enum value
/// {@endtemplate}
class MapTemplate extends ExtensionTemplate {
  /// {@macro enum_assist.additional_map_template}
  MapTemplate(
    String enumName,
    Iterable<EnumField> fields, {
    required String methodName,
    required String? Function(EnumField) getValue,
    required String typeAsString,
    required String docComment,
  }) : super(
          enumName,
          fields,
          methodName: methodName,
          defaultValue: null,
          returnValue: getValue,
          methodType: MethodType.map,
          typeAsString: typeAsString,
          docComment: docComment,
        );
}
