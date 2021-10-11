import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/configs/class_config.dart';
import 'package:enum_assist/src/helper_core.dart';
import 'package:enum_assist/src/settings.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.generator_helper}
/// A helper class for generating code for enums.
/// {@endtemplate}
class GeneratorHelper extends HelperCore {
  /// {@macro enum_assist.generator_helper}
  GeneratorHelper(
    Settings generator,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
          element,
          ClassConfig.mergeConfigs(
            generator.config,
            annotation,
            classElement: element,
          ),
        );

  @override
  Iterable<String> generate() sync* {
    // TODO: implement generate
    throw UnimplementedError();
  }
}
