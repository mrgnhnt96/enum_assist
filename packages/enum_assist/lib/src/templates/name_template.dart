import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/map_template.dart';

/// {@template enum_assist.name_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class NameTemplate extends MapTemplate {
  /// {@macro enum_assist.name_template}
  NameTemplate(String enumName, Iterable<EnumField> fields)
      : super(
          enumName,
          fields,
          getValue: (field) => field.getName,
          methodName: 'name',
          typeAsString: '$String',
        );
}
