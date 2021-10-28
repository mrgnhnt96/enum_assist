import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/map_template.dart';

/// {@template enum_assist.name_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class IntValueTemplate extends MapTemplate {
  /// {@macro enum_assist.name_template}
  IntValueTemplate(
    String enumName,
    Iterable<FieldData> fields,
  ) : super(
          enumName,
          fields,
          // intValue is always getting set from [HelperCore#fieldData]
          // so it should never be null
          getValue: (field) => '${field.intValue ?? field.index}',
          methodName: 'toInt',
          typeAsString: '$int',
          allowNulls: false,
          docComment: '''
/// The enum value converted to an integer''',
        );
}
