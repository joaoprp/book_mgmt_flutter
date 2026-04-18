import 'package:book_mgmt/widgets/fields/index.dart';
import 'package:book_mgmt/widgets/fields/medium_field_wrapper.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final List<dynamic>? errorMessage;
  final OnChangedCallback onChanged;
  final String title;
  final bool protected;

  const AuthField(
    this.title, {
    super.key,
    required this.onChanged,
    this.errorMessage,
    this.protected = false,
  });

  @override
  Widget build(BuildContext ctx) {
    return MediumField(
      child: TextFormField(
        obscureText: protected,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: title,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          errorText: errorMessage?.join('\n'),
        ),
      ),
    );
  }
}
