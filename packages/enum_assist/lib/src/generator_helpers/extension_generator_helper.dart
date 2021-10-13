import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/description_extension_template.dart';
import 'package:enum_assist/src/templates/map_extension_template.dart';
import 'package:enum_assist/src/templates/maybe_map_extension_template.dart';
import 'package:enum_assist/src/templates/name_template.dart';

/// A generator class for enum extensions
abstract class ExtensionGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateExtensions(String Function() additionalExtensions) {
    final buffer = StringBuffer()
      ..writeln('extension ${enumName}X on $enumName {')
      ..writeln(MapTemplate(enumName, fieldNames).toString())
      ..writeln(MaybeMapTemplate(enumName, fieldNames).toString())
      ..writeln(NameTemplate(enumName, fields).toString())
      ..writeln(DescriptionTemplate(enumName, fields).toString())
      ..writeln(additionalExtensions())
      ..writeln('}');

    return buffer.toString();
  }
}
