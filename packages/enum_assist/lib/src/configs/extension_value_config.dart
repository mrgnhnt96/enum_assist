import 'package:enum_assist/src/util/util.dart';
import 'package:source_gen/source_gen.dart';

/// {@template enum_assist.extension_value_config}
/// The configuration for the additional extension.
/// {@endtemplate}
class ExtensionValueConfig {
  /// {@macro enum_assist.extension_value_config}
  const ExtensionValueConfig._({
    required this.valueClassName,
    required this.valueType,
    required this.value,
  });

  /// The name of the class that represents the value.
  final String valueClassName;

  /// The type of the value.
  final String valueType;

  /// The value.
  final String value;

  /// resolve the [ExtensionValueConfig] from a `ConstantReader`.
  static ExtensionValueConfig resolve(ConstantReader reader) {
    const valueClassNameKey = 'valueClassName';
    const valueTypeKey = 'valueType';
    const valueKey = 'value';

    final valueClassName = reader.objectValue.type?.element?.displayName;

    final classDetails = '${reader.objectValue}';

    final match = RegExp(r'(?<![\w])ExtensionValue<.*?>(?= \()')
        .allMatches(classDetails)
        // get the lowest match in class heirarchy
        .last
        .group(0);
    if (match == null) throw _missingValueException(valueTypeKey);

    final typeWithBrackets = match.replaceAll('ExtensionValue', '');
    final valueType =
        typeWithBrackets.substring(1, typeWithBrackets.length - 1);

    final value = reader.peek(valueKey)?.stringValue;

    if (valueClassName == null) throw _missingValueException(valueClassNameKey);
    if (value == null) throw _missingValueException(valueKey);

    return ExtensionValueConfig._(
      valueClassName: valueClassName,
      valueType: valueType,
      value: value,
    );
  }

  static MissingValueException<String> _missingValueException(String key) =>
      MissingValueException('The value for the key "$key" is missing.');

  @override
  String toString() => '''
valueClassName: $valueClassName,
valueType: $valueType,
value: $value)
''';
}
