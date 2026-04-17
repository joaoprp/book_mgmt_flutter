import 'package:book_mgmt/data/token_client.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String host = 'localhost';
  final int port = 8000;

  final String path;

  ApiClient({required this.path});

  Uri getUri([String? query]) {
    var uri = Uri(host: host, port: port, path: 'api/$path');

    if (query != null && query.isNotEmpty) {
      uri = uri.replace(queryParameters: {'title': query});
    }

    return uri;
  }

  Future<Map<String, String>> getHeaders() async {
    String token = await TokenClient.getToken();

    return {'Authorization': 'Bearer $token'};
  }

  Future<http.Response> get([String? query]) async {
    Uri uri = getUri(query);
    var headers = await getHeaders();

    return await http.get(uri, headers: headers);
  }
}
