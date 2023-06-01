import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF295E2F);
  static const Color textColor = Color(0xFF7D9981);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor),
    ),
  );
}
