class ServerException implements Exception {
  ServerException([this.message = 'An Unexpected server error occurred.']);

  final String message;
}
