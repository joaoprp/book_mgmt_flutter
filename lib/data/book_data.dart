import 'dart:convert';

import 'package:book_mgmt/data/api_client.dart';
import 'package:book_mgmt/models/book.dart';
import 'package:http/http.dart';

String path = 'books';
var client = ApiClient(path: path);

List<Book> decodeResponse(Response response) {
  switch (response.statusCode) {
    case < 300:
      return (jsonDecode(
            response.body,
          )).map((entry) => Book.fromJson(entry)).toList()
          as List<Book>;
    case < 400:
      throw Exception('Redirect');
    case < 500:
      throw Exception('Client Error');
    case < 600:
      throw Exception('Server Error');
    default:
      throw Exception('Unhandled');
  }
}

Future<List<Book>> fetchBooks([String? query]) async {
  Response response = await client.get(query);

  List<dynamic> decoded = jsonDecode(response.body);
  var mapped = decoded.map((entry) => Book.fromJson(entry));

  return mapped.toList();
}
