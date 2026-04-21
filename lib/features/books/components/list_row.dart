import 'package:book_mgmt/models/book.dart';
import 'package:book_mgmt/utils/extensions/index.dart';
import 'package:book_mgmt/widgets/indices/indices.dart';
import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  final Book book;
  final Function onDelete;
  const ListRow(this.book, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext ctx) {
    return ExpansionTile(
      expandedCrossAxisAlignment: .start,
      minTileHeight: 80,
      // title: Text(book.title),
      title: Text(book.title).h1(),
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

// var r(book, ctx, onDelete) => Row(
//         mainAxisAlignment: .spaceBetween,
//         children: [
//           Text(book.title),
//           IconButton(
//             onPressed: () {
//               var messenger = ScaffoldMessenger.of(ctx);
//               try {
//                 onDelete(book);
//                 Alert.success(
//                   messenger,
//                   'Book with name ${book.title} and id ${book.id} removed successfully',
//                 );
//               } on HttpClientException {
//                 Alert.warning(
//                   messenger,
//                   'Unable to delete. Book likely to be removed from database already. Refresh your data and try again.',
//                 );
//               }
//             },
//             icon: Icon(Icons.delete),
//           ),
//         ],
//       )
