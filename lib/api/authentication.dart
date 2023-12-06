// packages
import 'dart:convert';
import 'package:http/http.dart';
// files
import 'package:stravovani_app/globals.dart';

Future<(int, Map?)> login({
  required String username,
  required String password,
}) async {
  final response = await post(
    Uri.parse("$apiURL/login"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      "username": username,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    return (200, jsonDecode(response.body) as Map);
  } else if (response.statusCode == 401) {
    return (401, null);
  } else {
    throw Exception("Failed to login");
  }
}

Future<bool> validateToken(String token) async {
  final response = await get(
    Uri.parse("$apiURL/validate-token"),
    headers: <String, String>{
      "Authorization": "Bearer $token",
    },
  );

  return {
    200: true,
    401: false,
  }[response.statusCode]!;
}
