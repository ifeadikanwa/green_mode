import 'package:flutter/material.dart';

class AppTheme {
  static const playFairDisplayFont = "Playfair Display";

  static final darkTheme = ThemeData(
      fontFamily: playFairDisplayFont,
      scaffoldBackgroundColor: Colors.black.withAlpha(225),
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: Colors.yellow,
        textColor: Colors.yellow,
        tilePadding: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.yellow,
          side: const BorderSide(
            color: Colors.yellow,
          ),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        secondary: Colors.yellow,
      ));
}
