import 'package:green_mode/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class WidgetConstants {
  //sizes
  static const double defaultTextSize = 14.0;
  static const double appMenuOptionsSpacing = 14.0;
  static const double defaultVerticalWidgetSpacing = 16.0;

  //text
  static const dropdownDefaultTextStyle =
      TextStyle(fontFamily: AppTheme.appFont, fontSize: 20.0);

  static const headingTextStyle = TextStyle(fontSize: 36.0);

  static const subHeadingTextStyle = TextStyle(fontSize: 20.0);
  static const smallerSubHeadingTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static const listItemTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );
  static const newsContentTextStyle = TextStyle(fontSize: 16.0);

  static const appMenuOptionTextStyle = TextStyle(fontSize: 24.0);
}
