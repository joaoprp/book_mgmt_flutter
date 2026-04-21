import 'package:book_mgmt/services/book_service.dart';
import 'package:book_mgmt/utils/helpers/response_validator.dart';
import 'package:book_mgmt/widgets/notification.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  final Function callback;
  const AddBook({super.key, required this.callback});

  @override
  State<AddBook> createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  final _formValues = <String, dynamic>{};

  Map<String, dynamic>? errors = {};

  Future<void> saveFields(BuildContext context) async {
    var state = ScaffoldMessenger.of(context);
    try {
      await addBook(_formValues);

      Alert.success(state, 'Book added successfully!');

      widget.callback();
    } on HttpClientException catch (e) {
      setState(() => errors = e.message?['errors']);

      Alert.error(state, e.message.toString());
    } catch (e) {
      Alert.error(state, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .start,
      children: [
        TextField(
          onChanged: (v) => _formValues['title'] = v,
          decoration: InputDecoration(
            hintText: 'Book Title',
            errorText: errors?['title']?.join('\n'),
          ),
        ),
        TextField(
          onChanged: (v) => _formValues['pages'] = v,
          decoration: InputDecoration(
            hintText: '# of pages',
            errorText: errors?['pages']?.join('\n'),
          ),
        ),

        NewIndex(),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () => saveFields(context),
          child: Text('Add'),
        ),
      ],
    );
  }
}

class NewIndex extends StatefulWidget {
  const NewIndex({super.key});

  @override
  State<NewIndex> createState() => _NewIndexState();
}

class _NewIndexState extends State<NewIndex> {
  final List<Color?> _bgColors = [];
  List<IndexForm> indices = [];

  void removeIndex(IndexForm idx) {
    setState(() {
      int pos = indices.indexOf(idx);
      indices.remove(idx);
      _bgColors.removeAt(pos);

      int k = 0;
      for (var c in _bgColors) {
        // final (k, v) = action;

        if (c == indices[k].bgColor) {
          print('match c and k');
        }

        c = k % 2 == 0 ? Colors.grey[100] : Colors.white;
        k++;
      }
    });

    for (var f in indices) {
      print(f.bgColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        ...indices,
        IconButton(
          onPressed: () {
            setState(() {
              _bgColors.add(
                _bgColors.length % 2 == 0 ? Colors.grey[100] : Colors.white,
              );
              indices.add(
                IndexForm(
                  onDelete: removeIndex,
                  bgColor: _bgColors[indices.length],
                ),
              );
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}

class IndexForm extends StatelessWidget {
  final Function onDelete;
  final Color? bgColor;

  const IndexForm({super.key, required this.onDelete, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(10),
      color: bgColor,
      child: Expanded(
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: .min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Index Title',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Index Page',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onDelete(this),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
