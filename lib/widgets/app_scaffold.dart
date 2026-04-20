import 'package:book_mgmt/widgets/app_header.dart';
import 'package:book_mgmt/widgets/drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  const AppScaffold({super.key, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: body,
      floatingActionButton: floatingActionButton,
      drawer: AppDrawer(),
    );
  }
}
