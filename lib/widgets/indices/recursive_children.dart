import 'package:book_mgmt/models/book.dart';
import 'package:flutter/material.dart';

class Children extends StatelessWidget {
  final List<Index>? children;
  const Children({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          for (var child in children!)
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.keyboard_arrow_right_rounded),
                  Text(child.title),
                ],
              ),
              subtitle: child.children == null
                  ? null
                  : Children(children: child.children),
            ),
        ],
      ),
    );
  }
}
