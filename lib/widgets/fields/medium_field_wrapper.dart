import 'package:flutter/material.dart';

class MediumField extends StatelessWidget {
  final Widget child;

  const MediumField(this.child, {super.key});

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
