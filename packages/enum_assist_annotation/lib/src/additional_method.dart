import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'additional_method.g.dart';

/// {@template enum_assist_annoation.additional_method_value}
/// Helper class to get the value for the [AdditionalMethod]
/// {@endtemplate}
abstract class AdditionalMethodValue {
  /// {@macro enum_assist_annoation.additional_method_value}
  const AdditionalMethodValue(this.value);

  /// The value to be used for an enum value.
  final Object? value;
}

/// {@template enum_assist.additional_method}
/// helper class to create additional methods
/// {@endtemplate}
@JsonSerializable()
class AdditionalMethod {
  /// {@macro enum_assist.additional_method}
  const AdditionalMethod({
    required this.defaultValue,
    required this.methodName,
    required this.isNullable,
  });

  /// {@macro enum_assist.additional_method}

  /// The method name to be used in the generated code.
  final String methodName;

  /// The default value to be used if an enum value is not specified.
  final Object defaultValue;

  /// will force null or non null values
  final bool isNullable;

  /// converts `Map` to [AdditionalMethod]
  static AdditionalMethod fromJson(Map<String, dynamic> json) =>
      _$AdditionalMethodFromJson(json);
}

/// {@macro enum_assist.additional_method}
///
/// {@template enum_assist.additional_method_maybe_map}
/// Uses `maybeMap` to create a method that returns the [value]
///
/// __Does not require__ all enums to be specified.
///
/// __can be null__
/// {@endtemplate}

@JsonSerializable()
class AdditionalMaybeMapMethod extends AdditionalMethod {
  /// {@macro enum_assist.additional_method}
  ///
  /// {@macro enum_assist.additional_method_maybe_map}
  const AdditionalMaybeMapMethod({
    required this.value,
    required String defaultValue,
    required String methodName,
    bool isNullable = true,
  }) : super(
          defaultValue: defaultValue,
          methodName: methodName,
          isNullable: isNullable,
        );

  /// the value to be passed for each enum
  final Object? value;

  @override
  AdditionalMaybeMapMethod fromJson(Map<String, dynamic> json) =>
      _$AdditionalMaybeMapMethodFromJson(json);
}

/// {@macro enum_assist.additional_method}
///
/// {@template enum_assist.additional_method_map}
/// Uses `map` to create a method that returns the [value]
///
/// __requires__ all enums to be specified.
///
/// __cannot be null__
/// {@endtemplate}
@JsonSerializable()
class AdditionalMapMethod extends AdditionalMethod {
  /// {@macro enum_assist.additional_method}
  ///
  /// {@macro enum_assist.additional_method_map}
  const AdditionalMapMethod({
    required this.value,
    required String defaultValue,
    required String methodName,
  }) : super(
          defaultValue: defaultValue,
          methodName: methodName,
          isNullable: false,
        );

  /// the value to be passed for each enum
  final Object value;

  @override
  AdditionalMapMethod fromJson(Map<String, dynamic> json) =>
      _$AdditionalMapMethodFromJson(json);
}
