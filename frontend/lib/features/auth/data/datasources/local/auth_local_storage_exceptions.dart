class LocalStorageException implements Exception {
  final String message;

  const LocalStorageException(this.message);

  @override
  String toString() => 'LocalStorageException: $message';
}