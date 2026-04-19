import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/data/book_data.dart';
import 'package:book_mgmt/data/response_validator.dart';
import 'package:book_mgmt/helpers/debounce.dart';
import 'package:book_mgmt/models/book.dart';
import 'package:book_mgmt/pages/books/add.dart';
import 'package:book_mgmt/widgets/indices/indices.dart';
import 'package:book_mgmt/widgets/notification.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryView();
}

class _LibraryView extends State<LibraryView> {
  final _sheetController = DraggableScrollableController();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  List<Book> data = [];
  double turns = 0.0;

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

  void toggleAnimation() {
    _sheetController.animateTo(
      _sheetController.size > 0 ? 0 : 0.9,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    setState(() => turns = _sheetController.size > 0 ? 0 : 0.125);
  }

  void callback() {
    _performSearch();
    toggleAnimation();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
        title: Text('Book Management'),
        actions: [],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              SearchBox(controller: _searchController),
              for (var book in data) BookEntry(book, onDelete: onDelete),
            ],
          ),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0,
            minChildSize: 0,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: .symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: .vertical(top: .circular(20)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: .only(top: 20),
                  children: [
                    Text(
                      'Add New Book',
                      style: TextStyle(fontSize: 40, fontWeight: .bold),
                      textAlign: .center,
                    ),
                    Container(
                      padding: .only(top: 20),
                      child: AddBook(callback: callback),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: IconButton(
        // onPressed: () => ctx.router.pushPath('/books/add'),
        onPressed: toggleAnimation,
        iconSize: 40,
        icon: AnimatedRotation(
          turns: turns,
          duration: Duration(milliseconds: 300),
          child: const Icon(Icons.add),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
        ),
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
              var messenger = ScaffoldMessenger.of(ctx);
              try {
                onDelete(book);
                Alert.success(
                  messenger,
                  'Book with name ${book.title} and id ${book.id} removed successfully',
                );
              } on HttpClientException {
                Alert.warning(
                  messenger,
                  'Unable to delete. Book likely to be removed from database already. Refresh your data and try again.',
                );
              } catch (e) {
                Alert.error(messenger, 'Internal Server Error.');
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Author: ${book.user?.name}'),
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

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  const SearchBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type to search...',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
