import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/additional_template.dart';

/// {@template enum_assist.name_template}
/// Returns the description from the enum field.
/// {@endtemplate}
class NameTemplate extends AdditionalMapTemplate<String> {
  /// {@macro enum_assist.name_template}
  NameTemplate(String enumName, Iterable<EnumField> fields)
      : super(
          enumName,
          fields,
          defaultValue: '',
          getValue: (field) => field.getName,
          methodName: 'name',
        );
}
