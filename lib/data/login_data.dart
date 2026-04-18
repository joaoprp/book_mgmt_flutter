import 'dart:convert';

import 'package:book_mgmt/data/api_client.dart';
import 'package:book_mgmt/data/response_validator.dart';
import 'package:book_mgmt/models/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String path = 'login';
var client = ApiClient(path: path);

Auth formatter(String body) {
  var auth = Auth.fromJson(jsonDecode(body) as Map<String, dynamic>);

  return auth;
}

Future<Auth> authenticate(Map<String, dynamic> payload) async {
  var response = await client.post(payload, false);

  var data = decodeResponse<Auth>(response, formatter);

  final storage = FlutterSecureStorage();

  await storage.write(key: 'token', value: data.token);

  return data;
}
