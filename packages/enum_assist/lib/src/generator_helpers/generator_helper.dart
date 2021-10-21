import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/generator_helpers/additional_extensions_generator_helper.dart';
import 'package:enum_assist/src/generator_helpers/extension_generator_helper.dart';
import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/generator_helpers/json_converter_generator_helper.dart';
import 'package:enum_assist/src/settings.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.enum_generator}
/// A helper class for generating code for enums.
/// {@endtemplate}
class GeneratorHelper extends HelperCore
    with
        ExtensionGeneratorHelper,
        JsonConverterGeneratorHelper,
        AdditionalExtensionsGeneratorHelper {
  /// {@macro enum_assist.enum_generator}
  GeneratorHelper(
    Settings generator,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
          element,
          ClassConfig.mergeConfigs(
            element,
            generator.config,
            annotation,
          ),
        );

  static final _warnings = <String>{};
  static final _topics = <String>{};

  /// warnings to be printed after generation
  static void addToWarnings({
    required String warning,
    required String where,
    required String what,
    required String action,
  }) {
    where = where.contains('.') ? where.split('.')[0] : where;

    final topic = what;

    if (_topics.contains(topic)) return;

    _topics.add(topic);

    _warnings.add('''
--- --- ---
[WARNING]: $warning
[WHERE]:   $where
[WHAT]:    $what
[ACTION]:  $action
--- --- ---''');
  }

  @override
  Iterable<String> generate() sync* {
    void printWarnings() {
      if (_warnings.isNotEmpty) {
        final warnings = _warnings.join('\n');

        // ignore: avoid_print
        print('''
$warnings
^^^ ^^^ ^^^
Total Warnings: ${_warnings.length}
''');
        _warnings.clear();
        _topics.clear();
      }
    }

    try {
      yield generateExtensions(generateAdditionalExtensions);

      if (config.createJsonConv) {
        yield generateJsonConverter();
      }
    } catch (_) {
      // clear warnings to give priority to the current error
      printWarnings();

      rethrow;
    }

    printWarnings();
  }
}
