import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/helpers/debounce.dart';
import 'package:book_mgmt/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class Books extends StatelessWidget {
  const Books({super.key});

  Future<List<BookModel>> fetchBooks() async {
    var url = Uri.parse('http://localhost:8000/api/books');
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    List<dynamic> decodedList = jsonDecode(response.body);

    var books = decodedList.map((book) => BookModel.fromJson(book));

    return books.toList();
  }

  @override
  Widget build(BuildContext ctx) {
    return FutureBuilder(
      future: fetchBooks(),
      builder: (context, snapshot) {
        {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            return LibraryView(data: snapshot.data);
          }
        }
      },
    );
  }
}

class LibraryView extends StatefulWidget {
  final List<BookModel>? data;

  const LibraryView({super.key, this.data});

  @override
  State<LibraryView> createState() => _LibraryView();
}

class _LibraryView extends State<LibraryView> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  List<BookModel>? data;

  Future<List<BookModel>> _performSearch(String query) async {
    var url = Uri.parse('http://localhost:8000/api/books');

    if (query.isNotEmpty) {
      url = url.replace(queryParameters: {'title': query});
    }
    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    List<dynamic> decodedList = jsonDecode(response.body);

    var books = decodedList.map((book) => BookModel.fromJson(book));

    setState(() {
      data = books.toList();
    });

    return books.toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _debouncer.run(() => _performSearch(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
        title: Text('Book Management'),
        actions: [
          IconButton(
            onPressed: () {
              ctx.router.pushPath('/books/add');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Type to search...',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          for (var book in data ?? widget.data!) Book(book: book),
        ],
      ),
    );
  }
}

class Book extends StatelessWidget {
  final dynamic book;
  Book({super.key, this.book});

  final List<int> colorCodes = <int>[300, 100];

  @override
  Widget build(BuildContext ctx) {
    return ExpansionTile(
      title: Text(book.title),
      subtitle: Text(book.user.name),
      children: [ListTile(title: Text(book.indexes?.title ?? ''))],
    );
  }
}
