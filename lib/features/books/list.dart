import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/core/exceptions/http/index.dart';
import 'package:book_mgmt/core/mixins/draggable_scrollable.dart';
import 'package:book_mgmt/features/books/components/add.dart';
import 'package:book_mgmt/features/books/components/list_row.dart';
import 'package:book_mgmt/services/book_service.dart';
import 'package:book_mgmt/utils/helpers/debounce.dart';
import 'package:book_mgmt/models/book.dart';
import 'package:book_mgmt/pages/books/add.dart';
import 'package:book_mgmt/widgets/app_scaffold.dart';
import 'package:book_mgmt/widgets/buttons/floating_button.dart';
import 'package:book_mgmt/widgets/fields/search.dart';
import 'package:book_mgmt/widgets/notification.dart';
import 'package:book_mgmt/widgets/vertical_scroll_page.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryView();
}

class _LibraryView extends State<LibraryView>
    with Debouncer, DraggableScrollable {
  List<Book> data = [];

  void _performSearch([String? query]) async {
    try {
      var books = await fetchBooks(query);
      setState(() => data = books);
    } on HttpUnauthorizedException {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Alert.error(
          ScaffoldMessenger.of(context),
          'Unauthorized. Redirected to login',
        );
        context.router.replacePath('/');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _performSearch();
    addDebounceListener(_performSearch);
  }

  @override
  void dispose() {
    super.dispose();
    disposeDebouncer();
  }

  void onDelete(Book book) async {
    await deleteBook(book.id);

    setState(() {
      data.remove(book);
    });
  }

  void callback() {
    _performSearch();
    toggleAnimation(setState);
  }

  void onPressed() => toggleAnimation(setState);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              SearchBox(controller: searchController),
              for (var book in data) ListRow(book, onDelete: onDelete),
            ],
          ),
          VerticalDrawerPage(
            Add.new,
            controller: sheetController,
            callback: callback,
          ),
        ],
      ),
      floatingActionButton: FloatingButton(onPressed: onPressed, turns: turns),
    );
  }
}
