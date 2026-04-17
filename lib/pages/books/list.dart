import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/data/book_data.dart';
import 'package:book_mgmt/helpers/debounce.dart';
import 'package:book_mgmt/models/book.dart';
import 'package:book_mgmt/widgets/indices/indices.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryView();
}

class _LibraryView extends State<LibraryView> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  List<Book> data = [];

  void _performSearch([String? query]) async {
    var books = await fetchBooks(query);

    setState(() => data = books);
  }

  @override
  void initState() {
    super.initState();
    _performSearch();

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
          for (var book in data) BookEntry(book: book),
        ],
      ),
    );
  }
}

class BookEntry extends StatelessWidget {
  final Book book;
  const BookEntry({super.key, required this.book});

  @override
  Widget build(BuildContext ctx) {
    return ExpansionTile(
      minTileHeight: 80,
      title: Text(book.title),
      subtitle: Text(book.user.name),
      children: [Indices(indices: book.indexes!)],
    );
  }
}
