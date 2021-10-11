class CheckedFromEnumAssistException implements Exception {
  const CheckedFromEnumAssistException({
    this.key,
    this.message,
    this.innerError,
  });

  final String? key;
  final String? message;
  final Exception? innerError;
}
