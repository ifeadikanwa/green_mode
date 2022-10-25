import 'package:flutter/material.dart';

class ThemedDivider extends StatelessWidget {
  const ThemedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Divider(color: (appTheme.brightness == Brightness.dark) ? Colors.white : Colors.black,);
  }
}
