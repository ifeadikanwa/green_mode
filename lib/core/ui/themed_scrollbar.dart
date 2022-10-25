import 'package:flutter/material.dart';

class ThemedScrollbar extends StatelessWidget {
  final Widget child;
  const ThemedScrollbar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return RawScrollbar(
      thumbColor: appTheme.colorScheme.secondary.withOpacity(0.5),
      thickness: 2.0,
      child: child,
    );
  }
}
