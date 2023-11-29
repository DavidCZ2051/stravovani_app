// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'package:stravovani_app/functions.dart';

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

    print(token);

    if (token == null) {
      if (!mounted) return;
      context.go("/login");
    } else {
      if (!mounted) return;
      context.go("/menu");
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
