import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/generator_helpers/extension_generator_helper.dart';
import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/generator_helpers/json_converter_generator_helper.dart';
import 'package:enum_assist/src/settings.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.enum_generator}
/// A helper class for generating code for enums.
/// {@endtemplate}
class GeneratorHelper extends HelperCore
    with ExtensionGeneratorHelper, JsonConverterGeneratorHelper {
  /// {@macro enum_assist.enum_generator}
  GeneratorHelper(
    Settings generator,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
          element,
          ClassConfig.mergeConfigs(
            generator.config,
            annotation,
          ),
        );

  @override
  Iterable<String> generate() sync* {
    yield generateExtensions();

    if (config.createJsonConv) {
      yield generateJsonConverter();
    }
  }
}
