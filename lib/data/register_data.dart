import 'package:book_mgmt/data/api_client.dart';
import 'package:book_mgmt/data/response_validator.dart';

String path = 'register';
var client = ApiClient(path: path);

bool formatter(String body) {
  return true;
}

Future<bool> register(Map<String, dynamic> payload) async {
  var response = await client.post(payload, false);

  return decodeResponse<bool>(response, formatter);
}
