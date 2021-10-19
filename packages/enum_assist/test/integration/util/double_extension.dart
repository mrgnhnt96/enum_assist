import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class DoubleExtension extends MaybeExtension<double> {
  const DoubleExtension(double value)
      : super(
          value,
          methodName: 'very far',
          defaultValue: 12,
        );
}
