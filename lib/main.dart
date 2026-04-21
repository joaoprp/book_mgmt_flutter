import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/guards/auth_guard.dart';
import 'package:book_mgmt/main.gr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: Login.page, initial: true),
    AutoRoute(path: '/register', page: Register.page),
    AutoRoute(path: '/books', page: LibraryView.page, guards: [AuthGuard()]),
  ];
}
