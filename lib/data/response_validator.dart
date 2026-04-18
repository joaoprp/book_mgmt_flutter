import 'dart:convert';

import 'package:http/http.dart';

T decodeResponse<T>(Response response, Function decoder) {
  switch (response.statusCode) {
    case < 300:
      return decoder(response.body);
    case < 400:
      throw Exception('Redirect');
    case < 500:
      throw HttpClientException(jsonDecode(response.body));
    case < 600:
      throw Exception('Server Error');
    default:
      throw Exception('Unhandled');
  }
}

class HttpClientException implements Exception {
  final Map<String, dynamic>? message;

  const HttpClientException([this.message]);
}
