import 'package:flutter/material.dart';

class AppTheme {
  static const playFairDisplayFont = "Playfair Display";

  static final darkTheme = ThemeData(
      fontFamily: playFairDisplayFont,
      scaffoldBackgroundColor: Colors.black.withAlpha(225),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: Colors.greenAccent.shade400,
        textColor: Colors.greenAccent.shade400,
        tilePadding: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.greenAccent.shade400,
          side: BorderSide(
            color: Colors.greenAccent.shade400,
          ),
        ),
      ),
      colorScheme: ColorScheme.dark(
        secondary: Colors.greenAccent.shade400,
      ));
}
