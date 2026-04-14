import 'package:book_mgmt/widgets/fields/index.dart';
import 'package:book_mgmt/widgets/fields/medium_field_wrapper.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.onChanged});

  final OnChangedCallback onChanged;

  @override
  Widget build(BuildContext ctx) {
    return MediumField(
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Enter your e-mail',
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
