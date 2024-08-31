import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
  ),
);

final ThemeData customTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 18, fontFamily: 'Arial'),
  ),
);
