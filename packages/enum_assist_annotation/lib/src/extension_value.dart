/// {@template enum_assist.additional_extension_value}
/// helper class to create the value for an additional extension
/// {@endtemplate}
abstract class ExtensionValue<T extends Object?> {
  /// {@macro enum_assist.additional_extension_value}
  const ExtensionValue(this.methodName, this.value);

  /// the name of the method
  ///
  /// must match spelling of `MapExtension.methodName`
  /// or `MaybeMapExtension.methodName`
  final String methodName;

  /// the value to be used in the generated code
  final T value;
}
