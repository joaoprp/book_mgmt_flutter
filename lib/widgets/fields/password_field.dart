import 'package:book_mgmt/widgets/fields/index.dart';
import 'package:book_mgmt/widgets/fields/medium_field_wrapper.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.onChanged});

  final OnChangedCallback onChanged;

  @override
  Widget build(BuildContext ctx) {
    return MediumField(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
