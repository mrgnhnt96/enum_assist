import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/map_template.dart';
import 'package:enum_assist/src/templates/maybe_map_template.dart';

/// A generator class for enum extensions
abstract class ExtensionGeneratorHelper implements HelperCore {
  /// generates extensions code
  Iterable<String> generateExtensions() sync* {
    yield 'extension ${enumName}X on $enumName {';
    {
      yield MapTemplate(enumName, fieldNames).toString();
      yield MaybeMapTemplate(enumName, fieldNames).toString();
    }
    yield '}';
  }
}
