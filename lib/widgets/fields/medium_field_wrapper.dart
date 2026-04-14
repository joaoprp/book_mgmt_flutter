import 'package:flutter/material.dart';

class MediumField extends StatelessWidget {
  const MediumField({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
          decoration: BoxDecoration(),
          child: child,
        ),
      ],
    );
  }
}
