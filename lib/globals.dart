// packages
import 'package:flutter/material.dart';
// files
import 'package:stravovani_app/classes.dart';

const String appVersion = "1.0.0-DEV";
const bool debug = true;

User user = User(
  name: "David Vobruba",
  credit: 3940,
  unwantedAllergens: [Allergens.soybeans],
);

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
  useMaterial3: true,
);

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
  useMaterial3: true,
);
