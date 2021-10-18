import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/json_converter_template.dart';

/// A generator class for enum extensions
abstract class JsonConverterGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateJsonConverter() {
    final buffer = StringBuffer()
      ..writeln(JsonConverterTemplate(enumName, fieldData, isNullable: false)
          .toString())
      ..writeln()
      ..writeln(JsonConverterTemplate(enumName, fieldData, isNullable: true)
          .toString());

    return '$buffer';
  }
}
