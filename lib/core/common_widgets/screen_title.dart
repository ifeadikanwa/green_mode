import 'package:flutter/material.dart';
import 'package:green_mode/core/constants/widget_constants.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: WidgetConstants.headingTextStyle,
    );
  }
}
