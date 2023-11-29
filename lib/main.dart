// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'globals.dart' as globals;
// routes
import 'package:stravovani_app/routes/menu.dart';
import 'package:stravovani_app/routes/allergens.dart';
import 'package:stravovani_app/routes/hce.dart';
import 'package:stravovani_app/routes/login.dart';
import 'package:stravovani_app/routes/initialize.dart';
import 'package:stravovani_app/routes/load.dart';

void main() {
  runApp(const App());
}

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const InitializeScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/load:type",
      builder: (context, state) => LoadScreen(
        loadType: state.pathParameters["type"]!.replaceAll(":type=", ""),
      ),
    ),
    GoRoute(
      path: "/menu",
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: "/alergeny",
      builder: (context, state) => const AllergensScreen(),
    ),
    GoRoute(
      path: "/hce",
      builder: (context, state) => const HceScreen(),
    ),
  ],
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Stravování",
      themeMode: ThemeMode.system,
      darkTheme: globals.darkThemeData,
      theme: globals.lightThemeData,
      routerConfig: router,
    );
  }
}
