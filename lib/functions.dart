// packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getTokenFromStorage() async {
  return null;
  const storage = FlutterSecureStorage();

  final token = await storage.read(key: "token");
  return token;
}

Future saveTokenToStorage(String token) async {
  const storage = FlutterSecureStorage();

  await storage.write(key: "token", value: token);
}
