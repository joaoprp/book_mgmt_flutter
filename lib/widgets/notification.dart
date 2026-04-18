import 'package:flutter/material.dart';

class Alert {
  static SnackBar build(String message, MaterialColor color) {
    return SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: .floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  static void info(ScaffoldMessengerState state, String message) {
    state.showSnackBar(build(message, Colors.blue));
  }

  static void error(ScaffoldMessengerState state, String message) {
    state.showSnackBar(build(message, Colors.red));
  }

  static void success(ScaffoldMessengerState state, String message) {
    state.showSnackBar(build(message, Colors.green));
  }

  static void warning(ScaffoldMessengerState state, String message) {
    state.showSnackBar(build(message, Colors.yellow));
  }
}
