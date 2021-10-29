import 'package:enum_assist_annotation/enum_assist_annotation.dart';

class FarMapExt extends MapExtension<double> {
  const FarMapExt(double value)
      : super(
          value,
          methodName: 'very far',
        );
}

class NullFarMapExt extends MapExtension<double?> {
  const NullFarMapExt([double? value])
      : super(value, methodName: 'very far', allowNulls: true);
}

class FarMaybeExt extends MaybeExtension<double> {
  const FarMaybeExt(double value)
      : super(
          value,
          methodName: 'very far',
          defaultValue: 12,
        );
}

class NullFarMaybeExt extends MaybeExtension<double?> {
  const NullFarMaybeExt([double? value])
      : super(value,
            methodName: 'very far', defaultValue: 12, allowNulls: true);
}
