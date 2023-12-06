// packages
import 'dart:convert';
import 'package:http/http.dart';
// files
import 'package:stravovani_app/globals.dart';

Future<(int, Map?)> getUser({
  required String token,
  required String userId,
}) async {
  final response = await get(
    Uri.parse("$apiURL/user/$userId"),
    headers: <String, String>{
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    return (200, jsonDecode(response.body) as Map);
  } else {
    throw Exception("Failed to get user");
  }
}
