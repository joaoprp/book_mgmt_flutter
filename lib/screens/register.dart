import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/widgets/fields/input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/fields/index.dart';

@RoutePage()
class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
        title: Text('Book Management'),
      ),
      body: Center(child: MyForm()),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final _formData = <String, dynamic>{};

  OnChangedCallback _onSaveField(String name) {
    return (String? value) => _formData[name] = value;
  }

  Future<void> _submitForm(BuildContext ctx) async {
    var router = ctx.router;

    var response = await register();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      router.pushPath('/');
    } else {
      throw Exception("Can't Register");
    }
  }

  Future<http.Response> register() {
    var url = Uri.parse('http://localhost:8000/api/register');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_formData),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        mainAxisAlignment: .center,
        children: [
          InputField(onChanged: _onSaveField('name'), hint: 'Enter your Name'),
          EmailField(onChanged: _onSaveField('email')),
          PasswordField(onChanged: _onSaveField('password')),
          InputField(
            onChanged: _onSaveField('password_confirmation'),
            hint: 'Confirm your password',
            obscureText: true,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _submitForm(ctx),
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
