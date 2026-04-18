import 'dart:convert';

import 'package:book_mgmt/data/token_client.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String host = 'localhost';
  final int port = 8000;
  final String path;

  late Uri uri = Uri(host: host, port: port, path: 'api/$path/');

  ApiClient({required this.path});

  void setQueryParams(Map<String, String> query) {
    uri.replace(queryParameters: query);
  }

  Future<Map<String, String>> getHeaders([bool protected = true]) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (protected) {
      String token = await TokenClient.getToken();

      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<http.Response> get([Map<String, String>? query]) async {
    if (query != null && query.isNotEmpty) {
      setQueryParams(query);
    }

    var headers = await getHeaders();

    return await http.get(uri, headers: headers);
  }

  Future<http.Response> post(
    Map<String, dynamic> body, [
    bool protected = true,
  ]) async {
    var headers = await getHeaders(protected);

    return http.post(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(int id) async {
    uri = uri.resolve('$id');

    var headers = await getHeaders();

    return http.delete(uri, headers: headers);
  }
}
