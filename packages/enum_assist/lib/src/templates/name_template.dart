import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/map_template.dart';

/// {@template enum_assist.name_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class NameTemplate extends MapTemplate {
  /// {@macro enum_assist.name_template}
  NameTemplate(String enumName, Iterable<FieldData> fields)
      : super(
          enumName,
          fields,
          getValue: (field) => field.getName,
          methodName: 'name',
          typeAsString: '$String',
          allowNulls: false,
          docComment: '''
/// Returns the name of the enum field
/// in a human readable format.''',
        );
}
