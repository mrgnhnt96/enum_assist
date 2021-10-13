import 'package:enum_assist/src/util/enum_helpers.dart';
import 'package:enum_assist/src/util/util.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.additional_extension_config}
/// The configuration for the additional extension.
/// {@endtemplate}
class AdditionalExtensionConfig {
  /// {@macro enum_assist.additional_extension_config}
  AdditionalExtensionConfig._({
    required this.methodName,
    required this.valueType,
    required this.methodType,
    required this.defaultValue,
    required this.className,
    required this.valueClassType,
  });

  /// {@macro enum_assist.additional_extension.default_value}
  final String methodName;

  /// {@macro enum_assist.additional_extension.default_value}
  final String valueType;

  /// {@macro enum_assist.additional_extension.method_type}
  final MethodType methodType;

  /// {@macro enum_assist.additional_extension.default_value}
  final String? defaultValue;

  /// name of the class used to create the extension
  final String className;

  /// type of class used to create the value
  final String valueClassType;

  /// checks if the [valueType] is nullable
  bool get isTypeNullable {
    return valueType.contains('?');
  }

  /// resolve the [AdditionalExtensionConfig] from a `ConstantReader`
  static AdditionalExtensionConfig? resolve(ConstantReader reader) {
    const methodNameKey = 'methodName';
    const methodTypeKey = 'methodType';
    const defaultValueKey = 'defaultValue';

    final methodNameValue = reader.peek('methodName')?.stringValue;
    if (methodNameValue == null) throw _methodNameException(methodNameKey);

    final methodTypeObj = reader.peek('methodType')?.objectValue;
    if (methodTypeObj == null) {
      throw _methodTypeException(methodTypeKey, methodNameValue);
    }

    final methodTypeValue =
        getEnumFromDartObject(methodTypeObj, MethodType.values);
    if (methodTypeValue == null) {
      throw _methodTypeException(methodTypeKey, methodNameValue);
    }

    final defaultValueValue = reader.peek('defaultValue')?.stringValue;

    if (_isMissingDefaultValue(defaultValueValue, methodTypeValue)) {
      throw _defaultValueException(
        defaultValueKey,
        methodTypeKey,
        methodNameValue,
      );
    }

    final classDetails = '${reader.objectValue}';

    final match = RegExp(r'(Map|MaybeMap)Extension<.*[, ]?>(?=\s\(\()')
        .firstMatch(classDetails)
        ?.group(0);

    if (match == null) {
      throw MissingValueException(
        'Could not locate the Type arguements for $classDetails',
      );
    }

    final cleanMatch = match.replaceAll(RegExp('(Map|MaybeMap)Extension'), '');
    final typeArguments =
        cleanMatch.substring(1, cleanMatch.length - 1).split(', ');

    final valueType = typeArguments[0];
    final valueClassType = typeArguments[1];
    final className = reader.objectValue.type!.element!.displayName;

    return AdditionalExtensionConfig._(
      methodName: methodNameValue,
      valueType: valueType,
      methodType: methodTypeValue,
      defaultValue: defaultValueValue,
      className: className,
      valueClassType: valueClassType,
    );
  }

  static MissingValueException<String> _methodTypeException(
      String key, String methodName) {
    return MissingValueException(
      'Missing value "$key" in method "$methodName". '
      'Choose `map` or `maybeMap`',
    );
  }

  static MissingValueException<String> _methodNameException(String key) {
    return MissingValueException(
      'Missing value "$key"! Make sure you have '
      'everything configured',
    );
  }

  static MissingValueException<String> _defaultValueException(
      String key, String typeKey, String methodName) {
    return MissingValueException(
      'Missing value "$key" in method "$methodName". '
      'the "$key" is required if the "$typeKey" is `maybeMap`',
    );
  }

  @override
  String toString() {
    return '''
methodName: $methodName,
valueType: $valueType,
methodType: $methodType,
defaultValue: $defaultValue,
className: $className,
valueClassType: $valueClassType,
''';
  }
}

bool _isMissingDefaultValue<T>(T defaultValue, MethodType methodType) {
  return methodType.maybeMap(
    orElse: () {
      return false;
    },
    maybeMapMethod: () {
      if (defaultValue == null) return true;
      return false;
    },
  )();
}
