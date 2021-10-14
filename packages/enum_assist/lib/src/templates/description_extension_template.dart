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
          docComment: '''
/// Returns the description of the enum field.
///
/// If the description is null, the doc comment of the enum field is returned.''',
        );

  @override
  String? prepValueForGen(String? value) {
    if (value == null) return null;
    final description = value
        .replaceAll(RegExp('{@(template|endtemplate|macro)*(?:[^}]*)}'), '')
        .replaceAll(RegExp('^\n*'), '');

    return '''
\'\'\'
$description\'\'\'''';
  }
}
