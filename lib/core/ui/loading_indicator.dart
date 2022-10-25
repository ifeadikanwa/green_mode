import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    
    return CircularProgressIndicator(
      color: appTheme.colorScheme.secondary,
    );
  }
}
