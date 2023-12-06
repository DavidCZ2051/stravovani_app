// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'package:stravovani_app/api/user.dart';
import 'package:stravovani_app/globals.dart' as globals;
import 'package:stravovani_app/classes.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key, required this.loadType, this.extra});

  final String loadType;
  final Map<String, dynamic>? extra;

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    selectLoadType();
  }

  void selectLoadType() {
    if (widget.loadType == "user") {
      loadUser();
    }
  }

  void loadUser() async {
    final respose = await getUser(
      userId: widget.extra!["user"],
      token: widget.extra!["token"],
    );

    Map user = respose.$2!;

    globals.user = User(
      id: user["id"],
      email: user["personalInfo"]["email"],
      firstName: user["name"]["firstName"],
      lastName: user["name"]["lastName"],
      phone: user["personalInfo"]["phone"],
      token: widget.extra!["token"],
    );

    // here load menu etc...
    context.go("/home");
  }

  Map<String, String> texts = {
    "user": "Načítání uživatele...",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircularProgressIndicator(),
                Text(texts[widget.loadType] ?? "Načítání..."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
