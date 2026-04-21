import 'dart:convert';

import 'package:book_mgmt/core/enums/index.dart';
import 'package:book_mgmt/services/api_client.dart';
import 'package:book_mgmt/utils/helpers/response_validator.dart';
import 'package:book_mgmt/models/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
  update API to move /login, /logout and /register into /auth/{service}
  to avoid calling `makeClient` with the proper string over service level
*/
ApiClient makeClient(String path) => ApiClient(path, tokenize: false);

String _token = StorageKey.token.name;

Auth formatter(String body) {
  var auth = Auth.fromJson(jsonDecode(body) as Map<String, dynamic>);

  return auth;
}

Future<Auth> authenticate(Map<String, dynamic> payload) async {
  var client = makeClient('login');
  var response = await client.post(payload, false);

  var data = decodeResponse<Auth>(response, formatter);

  final storage = FlutterSecureStorage();

  await storage.write(key: _token, value: data.token);

  return data;
}

Future<bool> unauthenticate() async {
  var client = makeClient('logout');
  var response = await client.post({});
  var success = decodeResponse(response, (body) => true);

  final storage = FlutterSecureStorage();
  final hasToken = await storage.containsKey(key: _token);

  if (hasToken) {
    await storage.delete(key: _token);
  }

  return success;
}

Future<bool> register(Map<String, dynamic> payload) async {
  var client = makeClient('register');
  var response = await client.post(payload, false);

  return decodeResponse<bool>(response, (body) => true);
}
