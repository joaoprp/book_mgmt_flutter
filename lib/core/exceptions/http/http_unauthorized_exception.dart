class HttpUnauthorizedException implements Exception {
  final Map<String, dynamic>? message;

  HttpUnauthorizedException([this.message]);
}
