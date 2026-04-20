import 'package:book_mgmt/services/api_client.dart';
import 'package:book_mgmt/helpers/response_validator.dart';

var client = ApiClient('register');

bool formatter(String body) {
  return true;
}

Future<bool> register(Map<String, dynamic> payload) async {
  var response = await client.post(payload, false);

  return decodeResponse<bool>(response, formatter);
}
