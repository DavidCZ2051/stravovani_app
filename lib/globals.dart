// packages
import 'package:flutter/material.dart';
// files
import 'package:stravovani_app/classes.dart';

const String appVersion = "1.0.0-DEV";
const String apiURL = "http://10.0.2.2:8080";
const bool debug = true;

User? user;

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
);

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
);
