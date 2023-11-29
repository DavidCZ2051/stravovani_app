// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'package:stravovani_app/functions.dart';
import 'package:stravovani_app/api/user.dart';

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
      userId: widget.extra!["userId"],
      token: widget.extra!["token"],
    );
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
