import 'package:enum_assist/src/util/extensions.dart';

/// {@template enum_assist.extension_value_config}
/// The configuration for the additional extension.
/// {@endtemplate}
class ExtensionValueConfig {
  /// {@macro enum_assist.extension_value_config}
  ExtensionValueConfig({
    required String methodName,
    required this.valueClassName,
    required this.valueType,
    required this.value,
  }) : methodName = methodName.toCamelCase();

  /// The name of the class that represents the value.
  final String methodName;

  /// The name of the top level class in the `EnumKey` annotation
  final String valueClassName;

  /// The type of the value.
  final String valueType;

  /// The value.
  final String value;

  @override
  String toString() {
    return '''
methodName: $methodName
valueClassName: $valueClassName
valueType: $valueType
value: $value
''';
  }
}
