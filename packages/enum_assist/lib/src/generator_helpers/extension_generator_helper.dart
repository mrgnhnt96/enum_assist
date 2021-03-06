import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/description_extension_template.dart';
import 'package:enum_assist/src/templates/int_extension_template.dart';
import 'package:enum_assist/src/templates/map_extension_template.dart';
import 'package:enum_assist/src/templates/maybe_map_extension_template.dart';
import 'package:enum_assist/src/templates/name_template.dart';
import 'package:enum_assist/src/templates/readable_template.dart';
import 'package:enum_assist/src/templates/serialized_extension_template.dart';

/// A generator class for enum extensions
abstract class ExtensionGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateExtensions(String Function() additionalExtensions) {
    final buffer = StringBuffer()
      ..writeln('''
/// Extensions for the enum $enumName''')
      ..writeln('extension ${enumName}X on $enumName {')
      ..writeln(MapExtensionTemplate(enumName, fieldNames).toString())
      ..writeln(MaybeMapExtensionTemplate(enumName, fieldNames).toString());

    if (config.createName) {
      buffer.writeln(NameTemplate(enumName, fieldData).toString());
    }

    if (config.createToInt) {
      buffer.writeln(IntValueTemplate(enumName, fieldData).toString());
    }

    if (config.createReadable) {
      buffer.writeln(ReadableTemplate(enumName, fieldData).toString());
    }

    if (config.createDescription) {
      buffer.writeln(DescriptionTemplate(enumName, fieldData).toString());
    }

    if (config.createSerialized) {
      buffer.writeln(SerializedTemplate(
        enumName,
        fieldData,
        createJsonConv: config.createJsonConv,
      ).toString());
    }

    buffer
      ..writeln(additionalExtensions())
      ..writeln('}');

    return buffer.toString();
  }
}
