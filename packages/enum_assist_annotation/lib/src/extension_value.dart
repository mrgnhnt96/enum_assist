/// {@template enum_assist.additional_extension_value}
/// helper class to create the value for an additional extension
/// {@endtemplate}
abstract class ExtensionValue<T> {
  /// {@macro enum_assist.additional_extension_value}
  const ExtensionValue(this.value);

  /// the value to be used in the generated code
  final T value;
}
