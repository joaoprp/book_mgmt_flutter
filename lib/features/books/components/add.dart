import 'package:book_mgmt/pages/books/add.dart';
import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback callback;
  const Add({super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
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
    );
  }
}
