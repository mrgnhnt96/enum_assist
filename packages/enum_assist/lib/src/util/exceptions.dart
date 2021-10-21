/// {@template enum_exception}
/// The Exception thrown by EnumAssist
/// {@endtemplate}
class EnumException extends ArgumentError {
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
