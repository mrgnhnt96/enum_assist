// ignore_for_file: comment_references

/// {@template enum_assist.exception}
/// The exception thrown by the [EnumAssist] class.
/// {@endtemplate}
class CheckedFromEnumAssistException implements Exception {
  /// {@macro enum_assist.exception}
  const CheckedFromEnumAssistException({
    this.key,
    this.message,
    this.innerError,
  });

  /// The key of the exception thrown.
  final String? key;

  /// The message of the exception.
  final String? message;

  /// Any inner error that caused the exception.
  final Exception? innerError;
}
