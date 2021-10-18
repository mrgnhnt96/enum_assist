import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/description_extension_template.dart';
import 'package:enum_assist/src/templates/map_extension_template.dart';
import 'package:enum_assist/src/templates/maybe_map_extension_template.dart';
import 'package:enum_assist/src/templates/name_template.dart';
import 'package:enum_assist/src/templates/serialized_extension_template.dart';

/// A generator class for enum extensions
abstract class ExtensionGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateExtensions(String Function() additionalExtensions) {
    final buffer = StringBuffer()
      ..writeln('''
/// Extensions for the enum $enumName''')
      ..writeln('extension ${enumName}X on $enumName {')
      ..writeln(MapTemplate(enumName, fieldNames).toString())
      ..writeln(MaybeMapTemplate(enumName, fieldNames).toString())
      ..writeln(NameTemplate(enumName, fieldData).toString())
      ..writeln(DescriptionTemplate(enumName, fieldData).toString());

    if (config.createJsonConv) {
      buffer.writeln(SerializedTemplate(enumName, fieldData).toString());
    }

    buffer
      ..writeln(additionalExtensions())
      ..writeln('}');

    return buffer.toString();
  }
}
