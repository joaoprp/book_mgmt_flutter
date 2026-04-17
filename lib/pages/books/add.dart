import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/widgets/fields/input_field.dart';
import 'package:book_mgmt/widgets/fields/medium_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class AddBook extends StatelessWidget {
  const AddBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Book Management'),
      ),
      body: Center(child: MediumField(child: BookEntry())),
    );
  }
}

class BookEntry extends StatefulWidget {
  const BookEntry({super.key});

  @override
  State<BookEntry> createState() => _BookEntry();
}

class _BookEntry extends State<BookEntry> {
  final _formValues = <String, dynamic>{};

  Future<void> saveFields(BuildContext context) async {
    var router = context.router;

    final storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');

    var response = await http.post(
      Uri.parse('http://localhost:8000/api/books'),
      body: jsonEncode(_formValues),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      router.pushPath('/books');
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
          decoration: InputDecoration(hintText: 'Book Title'),
        ),
        TextField(
          onChanged: (v) => _formValues['pages'] = v,
          decoration: InputDecoration(hintText: '# of pages'),
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
