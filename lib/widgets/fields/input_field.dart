import 'package:book_mgmt/widgets/fields/index.dart';
import 'package:book_mgmt/widgets/fields/medium_field_wrapper.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.obscureText = false,
  });

  final OnChangedCallback onChanged;
  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext ctx) {
    return MediumField(
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
