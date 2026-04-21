import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double turns;
  const FloatingButton({super.key, required this.onPressed, this.turns = 0});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 40,
      icon: AnimatedRotation(
        turns: turns,
        duration: Duration(milliseconds: 300),
        child: const Icon(Icons.add),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
