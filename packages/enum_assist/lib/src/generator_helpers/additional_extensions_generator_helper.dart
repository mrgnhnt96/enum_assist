import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/adaptive_template.dart';
import 'package:enum_assist/src/templates/extension_template.dart';
import 'package:enum_assist/src/util/exceptions.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// A generator class for enum extensions
abstract class AdditionalExtensionsGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateAdditionalExtensions() {
    final buffer = StringBuffer();

    for (final entry in extensions.entries) {
      final name = entry.key;
      final value = entry.value;

      final notNullableAndIsMap =
          !value.allowNulls && value.methodType == MethodType.map;

      if (notNullableAndIsMap) {
        FieldData? field;
        try {
          field = fieldData.firstWhere(
              (element) => element.extensions.containsKey(name) == false);
        } catch (_) {
          // do nothing, all fields have the required extension
        }

        if (field != null) {
          throw '${field.wholeName} needs to have $name extension. (${value.valueClassName})';
        }
      }
    }

    for (final extension in extensions.values) {
      try {
        buffer
          ..write(
            AdaptiveTemplate(
              enumName,
              fieldData,
              methodName: extension.methodName,
              docComment: extension.getDocComment(),
              defaultValue: extension.defaultValue,
              methodType: extension.methodType,
              typeAsString: extension.valueType,
              allowNulls: extension.allowNulls,
              getValue: (field) {
                final extensionConfig =
                    field.getExtension(extension.methodName);
                final returnValue = extensionConfig?.value ?? unassigned;

                return returnValue;
              },
            ).toString(),
          )
          ..writeln();
      } on MissingExtensionValueException catch (e) {
        print(e); // ignore: avoid_print
        continue;
      } on NullValueException catch (e) {
        print(e); // ignore: avoid_print
        continue;
      }
    }

    return buffer.toString();
  }
}
