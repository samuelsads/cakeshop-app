import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityToken {
  Future<void> saveToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "token", value: token);
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    return token.toString();
  }
}
