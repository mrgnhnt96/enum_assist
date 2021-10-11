import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart'; // ignore: implementation_imports
import 'package:enum_assist/src/settings.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_helper.dart';

/// {@template enum_assist_generator}
/// Generates a [EnumAssist] class for each enum
/// {@endtemplate}
class EnumAssistGenerator extends GeneratorForAnnotation<EnumAssist> {
  /// {@macro enum_assist_generator}
  ///
  /// creates [EnumAssistGenerator] from the settings
  EnumAssistGenerator.fromSettings(this._settings);

  final Settings _settings;

  /// Settings for the generator.
  EnumAssist get config => _settings.config;

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (!element.library!.isNonNullableByDefault) {
      throw InvalidGenerationSourceError(
        'Generator cannot target libraries that have not been migrated to '
        'null-safety.',
        element: element,
      );
    }

    if (!(element is ClassElement && element.isEnum)) {
      throw InvalidGenerationSourceError(
        '`@EnumAssist` can only be used on enum.',
        element: element,
      );
    }

    final helper = GeneratorHelper(_settings, element, annotation);
    return helper.generate();
  }
}
