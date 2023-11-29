// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
// files
import 'package:stravovani_app/globals.dart' as globals;

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${globals.user!.firstName} ${globals.user!.lastName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Kredit: ${globals.user!.credit} Kč",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              selected: true,
              title: const Text("Objednávka"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text("Platby"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Účet"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.no_food),
              title: const Text("Alergeny"),
              onTap: () {
                context.go("/alergeny");
              },
            ),
            if (Platform.isAndroid || globals.debug)
              ListTile(
                leading: const Icon(Icons.nfc),
                title: const Text("Mobilní karta"),
                onTap: () {
                  context.go("/hce");
                },
              ),
          ],
        ),
      ),
    );
  }
}
