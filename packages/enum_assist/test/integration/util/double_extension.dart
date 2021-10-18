import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class DoubleValue extends ExtensionValue<double> {
  const DoubleValue(double value) : super('very far', value);
}

class DoubleExtension extends MaybeMapExtension<double, DoubleValue> {
  const DoubleExtension() : super('very far', defaultValue: 12);
}
