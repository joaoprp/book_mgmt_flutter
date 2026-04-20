import 'package:auto_route/auto_route.dart';

import 'package:book_mgmt/services/login_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text('Menu'),
          ),
          Expanded(
            child: ListView(padding: .zero, children: []),
          ),
          Divider(),
          Logout(),
        ],
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  Future<void> logout(BuildContext context) async {
    var router = context.router;
    try {
      await unauthenticate();
      router.replacePath('/');
    } catch (e) {
      print('cute error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Logout'),
      onTap: () => logout(context),
    );
  }
}
