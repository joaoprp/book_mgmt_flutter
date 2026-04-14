import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../widgets/fields/index.dart';

@RoutePage()
class Login extends StatelessWidget {
  const Login({super.key});

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

    final storage = FlutterSecureStorage();
    var response = await login();

    if (response.statusCode == 200) {
      var auth = AuthModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      await storage.write(key: 'token', value: auth.token);

      router.pushPath('/books');
    } else {
      throw Exception("Can't Login");
    }
  }

  Future<http.Response> login() {
    var url = Uri.parse('http://localhost:8000/api/login');
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
          EmailField(onChanged: _onSaveField('email')),
          PasswordField(onChanged: _onSaveField('password')),
          Row(
            spacing: 16,
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _submitForm(ctx),
                child: Text('Login'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => ctx.router.pushPath('/register'),
                child: Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
