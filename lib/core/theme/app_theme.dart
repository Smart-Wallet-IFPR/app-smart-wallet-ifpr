import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primarySwatch: Colors.indigo,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
