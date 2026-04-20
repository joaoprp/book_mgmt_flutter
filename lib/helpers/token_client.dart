import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenClient {
  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();

    String? token = await storage.read(key: 'token');

    return token ?? '';
  }
}
