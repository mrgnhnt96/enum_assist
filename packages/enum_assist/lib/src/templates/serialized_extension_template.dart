import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/map_template.dart';

/// {@template enum_assist.description_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class SerializedTemplate extends MapTemplate {
  /// {@macro enum_assist.description_template}
  SerializedTemplate(
    String enumName,
    Iterable<FieldData> fields, {
    required bool createJsonConv,
  }) : super(
          enumName,
          fields,
          getValue: (field) {
            if (createJsonConv) {
              return '${field.enumName}Conv._${field.fieldName}Name';
            } else {
              return field.getSerializedValue;
            }
          },
          methodName: 'serialized',
          typeAsString: '$Object',
          allowNulls: false,
          docComment: '''
/// Returns the serialized value of the enum field.''',
        );

  @override
  String? prepValueForGen(String? value) => value;
}
