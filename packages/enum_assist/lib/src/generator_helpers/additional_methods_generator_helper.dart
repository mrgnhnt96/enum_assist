import 'package:enum_assist/src/generator_helpers/helper_core.dart';
import 'package:enum_assist/src/templates/adaptive_template.dart';
import 'package:enum_assist/src/util/exceptions.dart';

/// A generator class for enum extensions
abstract class AdditionalExtensionsGeneratorHelper implements HelperCore {
  /// generates extensions code
  String generateAdditionalExtensions() {
    final buffer = StringBuffer();

    for (final extension in config.additionalExtensions) {
      try {
        buffer.write(
          AdaptiveTemplate(
            enumName,
            fields,
            methodName: extension.methodName,
            docComment: extension.getDocComment(),
            defaultValue: extension.defaultValue,
            methodType: extension.methodType,
            typeAsString: extension.valueType,
            getValue: (field) {
              final extensionValueConfig =
                  field.getExtensionValue(extension.valueClassType);
              final returnValue = extensionValueConfig?.value;

              if (!extension.isTypeNullable && returnValue == null) {
                throw MissingExtensionValueException(
                  field.wholeName,
                  extension.methodName,
                );
              }

              return returnValue;
            },
          ).toString(),
        );
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
