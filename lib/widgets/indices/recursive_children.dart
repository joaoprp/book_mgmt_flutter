import 'package:book_mgmt/models/indice.dart';
import 'package:flutter/material.dart';

class Children extends StatelessWidget {
  final List<Index>? children;
  const Children({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: Column(
        children: [
          for (var child in children!)
            ListTile(
              title: Row(
                spacing: 4,
                children: [Icon(Icons.circle, size: 8), Text(child.title)],
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
