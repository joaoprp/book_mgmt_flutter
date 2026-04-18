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

  void onDelete(Book book) async {
    await deleteBook(book.id);

    setState(() {
      data.remove(book);
    });
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
          for (var book in data) BookEntry(book, onDelete: onDelete),
        ],
      ),
    );
  }
}

class BookEntry extends StatelessWidget {
  final Book book;
  final Function onDelete;
  const BookEntry(this.book, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext ctx) {
    return ExpansionTile(
      expandedCrossAxisAlignment: .start,
      minTileHeight: 80,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(book.title),
          IconButton(
            onPressed: () {
              final snackBar = SnackBar(
                content: Text(
                  'Book with name ${book.title} and id ${book.id} removed successfully',
                ),
                backgroundColor: Colors.green,
                behavior: .floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
              onDelete(book);
              ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Author: ${book.user.name}'),
          Text('Pages: ${book.pages}'),
        ],
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Chapters',
            style: TextStyle(fontSize: 18, fontWeight: .bold),
          ),
        ),
        Indices(indices: book.indexes!),
      ],
    );
  }
}
