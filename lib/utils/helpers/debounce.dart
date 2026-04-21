import 'dart:async';

import 'package:flutter/material.dart';

class DebouncerAction {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DebouncerAction({required this.milliseconds});

  void run(VoidCallback action) {
    // Cancel the previous timer if it's still active
    _timer?.cancel();

    // Start a new timer
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

mixin class Debouncer {
  final searchController = TextEditingController();
  final _debouncer = DebouncerAction(milliseconds: 500);

  void disposeDebouncer() {
    searchController.dispose();
    _debouncer.dispose();
  }

  void addDebounceListener(Function request) => searchController.addListener(
    () => _debouncer.run(() => request(searchController.text)),
  );
}
