// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'package:stravovani_app/functions.dart';
import 'package:stravovani_app/api/authentication.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  @override
  void initState() {
    super.initState();
    authenticate();
  }

  void authenticate() async {
    final token = await getTokenFromStorage();

    print("Loaded token: $token");

    if (token == null) {
      if (!mounted) return;
      context.go("/login");
    } else {
      if (await validateToken(token)) {
        if (!mounted) return;
        context.go("/menu");
      } else {
        // TODO: Token has expired, get a new one in the background
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
