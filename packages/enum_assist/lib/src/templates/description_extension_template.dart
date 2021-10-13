import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/maybe_map_template.dart';

/// {@template enum_assist.description_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class DescriptionTemplate extends MaybeMapTemplate {
  /// {@macro enum_assist.description_template}
  DescriptionTemplate(String enumName, Iterable<EnumField> fields)
      : super(
          enumName,
          fields,
          defaultValue: null,
          getValue: (field) => field.getDescription,
          methodName: 'description',
          typeAsString: '$String?',
        );
}
