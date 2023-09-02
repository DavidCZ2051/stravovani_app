// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'globals.dart' as globals;
// routes
import 'package:stravovani_app/routes/menu.dart';
import 'package:stravovani_app/routes/allergens.dart';

void main() {
  runApp(const App());
}

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: "/alergeny",
      builder: (context, state) => const AllergensScreen(),
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
