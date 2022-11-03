import 'package:flutter/material.dart';

class AppTheme {
  static const appFont = "Playfair Display";

  static final darkTheme = ThemeData(
      fontFamily: appFont,
      scaffoldBackgroundColor: Colors.black.withAlpha(225),
      primaryColor: Colors.greenAccent.shade400,
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: Colors.greenAccent.shade400,
        textColor: Colors.greenAccent.shade400,
        tilePadding: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.greenAccent.shade400,
          side: BorderSide(
            color: Colors.greenAccent.shade400,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent.shade400,
          textStyle: const TextStyle(
            fontFamily: appFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.greenAccent.shade400, width: 2.0),
        ),
        iconColor: Colors.white,
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.greenAccent.shade400,
        secondary: Colors.greenAccent.shade400,
      ));
}
