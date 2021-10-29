// ignore_for_file: comment_references

/// {@template enum_exception}
/// The Exception thrown by EnumAssist
/// {@endtemplate}
abstract class EnumException extends ArgumentError {
  /// {@macro enum_exception}
  EnumException({
    required this.error,
    required this.what,
    required this.where,
    required this.rule,
    required this.fix,
  }) : super('''

--- --- ---
[ERROR]:  $error
[WHERE]:  $where
[WHAT]:   $what
[RULE]:   $rule
[FIX]:    $fix
--- --- ---
''');

  /// The summary of the error
  final String error;

  /// The enum that caused the error
  final String where;

  /// why the error occurred
  final String what;

  /// the rule that was violated
  final String rule;

  /// the fix to the error
  final String fix;
}

/// {@template enum_exception.duplicate_method}
/// The Exception thrown when a duplicate method is found
/// {@endtemplate}
class DuplicateMethodException extends EnumException {
  /// {@macro enum_exception.duplicate_method}
  DuplicateMethodException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Duplicated Method Name',
          where: where,
          what: what,
          rule: 'Method names must be unique for each `enum`',
          fix: fix,
        );
}

/// {@template enum_exception.duplicate_extension}
/// The Exception thrown when a duplicate extension is declared
/// {@endtemplate}
class DuplicateExtensionException extends EnumException {
  /// {@macro enum_exception.duplicate_method}
  DuplicateExtensionException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Duplicated Extension Declaration',
          where: where,
          what: what,
          rule: 'Extensions can only be declared '
              'once for a single enum field',
          fix: fix,
        );
}

/// {@template enum_exception.missing_field}
/// The Exception thrown when a value is missing
/// {@endtemplate}
class MissingFieldException extends EnumException {
  /// {@macro enum_exception.missing_field}
  MissingFieldException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Missing Required Fields',
          where: where,
          what: what,
          rule: 'All methods must have a method name [methodName], '
              'method type, a value, and whether `null`s may '
              'be a return value [allowNulls]',
          fix: fix,
        );
}

/// {@template enum_exception.null_return}
/// The Exception thrown when a method returns null
/// and the return type is not nullable
/// {@endtemplate}
class NullReturnedOnNonNullException extends EnumException {
  /// {@macro enum_exception.null_return}
  NullReturnedOnNonNullException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Null Value on Non-Null Return Type',
          where: where,
          what: what,
          rule: 'A method may not return `null` when the '
              '`allowNulls` flag is set to `false`',
          fix: fix,
        );
}

/// {@template enum_exception.missing_extension_declaration}
/// The Exception thrown when an extension is missing
/// from the [EnumValue.extensions] list
/// {@endtemplate}
class MissingDeclaredExtensionException extends EnumException {
  /// {@macro enum_exception.missing_extension_declaration}
  MissingDeclaredExtensionException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Missing Declared Extension',
          where: where,
          what: what,
          rule: 'If the method is a type `MapExtension` and `allowNulls` is '
              'equal to `false` (default), then each field must be annotated '
              'with @EnumValue & contain the method within the '
              '`extensions: [...]` argument',
          fix: fix,
        );
}

/// {@template enum_exception.invalid_serialized_value_type}
/// The Exception thrown when a serialized value is not a string or int
/// {@endtemplate}
class InvalidSerializedTypeException extends EnumException {
  /// {@macro enum_exception.invalid_serialized_value_type}
  InvalidSerializedTypeException({
    required String where,
    required String what,
    required String fix,
  }) : super(
          error: 'Invalid Serialized Value Type',
          where: where,
          what: what,
          rule: 'The serialized type must be a `String` or `int`',
          fix: fix,
        );
}
