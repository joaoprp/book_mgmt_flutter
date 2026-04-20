import 'package:book_mgmt/core/enums/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenClient {
  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();

    String? token = await storage.read(key: StorageKey.token.name);

    return token ?? '';
  }
}
