import 'dart:convert';

import 'package:book_mgmt/data/api_client.dart';
import 'package:book_mgmt/data/response_validator.dart';
import 'package:book_mgmt/models/book.dart';
import 'package:http/http.dart';

String path = 'books';
var client = ApiClient(path: path);

Book format(dynamic json) {
  return Book.fromJson(json);
}

List<Book> formatList(List<dynamic> json) {
  return json.map((entry) => format(entry)).toList();
}

T formatter<T>(String body) {
  var json = jsonDecode(body);
  return (json is List ? formatList(json) : format(json)) as T;
}

Future<List<Book>> fetchBooks([String? query]) async {
  Response response = await client.get();

  return decodeResponse<List<Book>>(response, formatter);
}

Future<Book> addBook(Map<String, dynamic> payload) async {
  Response response = await client.post(payload);

  return decodeResponse<Book>(response, formatter);
}

Future<bool> deleteBook(int id) async {
  Response response = await client.delete(id);

  if (response.statusCode != 204) {
    throw Exception("Can't delete.");
  }

  return true;
}
