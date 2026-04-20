import 'package:auto_route/auto_route.dart';
import 'package:book_mgmt/core/enums/index.dart';
import 'package:book_mgmt/main.gr.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final storage = FlutterSecureStorage();

    if (await storage.containsKey(key: StorageKey.token.name)) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      // tip: use resolver.redirectUntil to have the redirected route
      // automatically removed from the stack when the resolver is completed
      resolver.redirectUntil(Login());
    }
  }
}
