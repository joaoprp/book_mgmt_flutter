import 'package:book_mgmt/models/indice.dart';
import 'package:book_mgmt/widgets/indices/recursive_children.dart';
import 'package:flutter/material.dart';

class Indices extends StatelessWidget {
  final List<Index> indices;
  const Indices({super.key, required this.indices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index in indices)
          ListTile(
            title: Row(
              spacing: 4,
              children: [Icon(Icons.circle, size: 8), Text(index.title)],
            ),
            subtitle: index.children == null
                ? null
                : Children(children: index.children),
          ),
      ],
    );
  }
}
