import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/data/register_data.dart';
import 'package:book_mgmt/data/response_validator.dart';
import 'package:book_mgmt/widgets/fields/auth_field.dart';
import 'package:book_mgmt/widgets/notification.dart';
import 'package:flutter/material.dart';

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

  Map<String, dynamic>? errors = {};

  OnChangedCallback _onSaveField(String name) {
    return (String? value) {
      setState(() => errors?[name] = null);
      _formData[name] = value;
    };
  }

  Future<void> _submitForm(BuildContext ctx) async {
    var router = ctx.router;
    var messenger = ScaffoldMessenger.of(ctx);

    try {
      await register(_formData);

      router.replacePath('/');
    } on HttpClientException catch (e) {
      setState(() => errors = e.message?['errors']);
      Alert.error(messenger, e.message?['message']);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        mainAxisAlignment: .center,
        children: [
          AuthField(
            'Enter your Name',
            onChanged: _onSaveField('name'),
            errorMessage: errors?['name'],
          ),
          AuthField(
            'Enter your e-mail',
            onChanged: _onSaveField('email'),
            errorMessage: errors?['email'],
          ),
          AuthField(
            'Password',
            onChanged: _onSaveField('password'),
            errorMessage: errors?['password'],
            protected: true,
          ),
          AuthField(
            'Confirm your password',
            onChanged: _onSaveField('password_confirmation'),
            errorMessage: errors?['password_confirmation'],
            protected: true,
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
