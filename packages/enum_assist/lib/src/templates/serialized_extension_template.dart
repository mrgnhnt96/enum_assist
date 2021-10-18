import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/map_template.dart';

/// {@template enum_assist.description_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class SerializedTemplate extends MapTemplate {
  /// {@macro enum_assist.description_template}
  SerializedTemplate(String enumName, Iterable<FieldData> fields)
      : super(
          enumName,
          fields,
          getValue: (field) => '${field.enumName}Conv._${field.fieldName}Name',
          methodName: 'serialized',
          typeAsString: '$String',
          allowNulls: false,
          docComment: '''
/// Returns the serialized value of the enum field.''',
        );

  @override
  String? prepValueForGen(String? value) => value;
}
