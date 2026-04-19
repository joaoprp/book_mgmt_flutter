import 'package:book_mgmt/data/book_data.dart';
import 'package:book_mgmt/data/response_validator.dart';
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

class NewIndex extends StatelessWidget {
  const NewIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: IndexForm(),
    );
  }
}

class IndexForm extends StatelessWidget {
  const IndexForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          enabled: false,
          decoration: InputDecoration(
            hintText: 'Index Title',
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
        TextFormField(
          enabled: false,
          decoration: InputDecoration(
            hintText: 'Index Page',
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ],
    );
  }
}
