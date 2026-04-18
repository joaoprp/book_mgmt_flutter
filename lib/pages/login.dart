import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/data/login_data.dart';
import 'package:book_mgmt/data/response_validator.dart';
import 'package:book_mgmt/widgets/fields/auth_field.dart';
import 'package:book_mgmt/widgets/notification.dart';
import 'package:flutter/material.dart';

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
      await authenticate(_formData);

      router.replacePath('/books');
    } on HttpClientException catch (e) {
      setState(() => errors = e.message?['errors']);

      Alert.error(messenger, e.message?['message'] as String);
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
          LoginButtons(submit: () => _submitForm(ctx)),
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  final VoidCallback submit;
  const LoginButtons({super.key, required this.submit});

  @override
  Widget build(BuildContext ctx) {
    return Row(
      spacing: 16,
      mainAxisAlignment: .center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: submit,
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
    );
  }
}
