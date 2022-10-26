import 'package:flutter/material.dart';
import 'package:green_mode/core/constants/widget_constants.dart';

class AppMenuOption extends StatelessWidget {
  final String optionName;
  final void Function() optionAction;
  final bool isCurrentLocation;

  const AppMenuOption({
    Key? key,
    required this.optionName,
    required this.optionAction,
    required this.isCurrentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return GestureDetector(
      onTap: optionAction,
      child: (isCurrentLocation)
          ? Text(
              optionName,
              style: WidgetConstants.appMenuOptionTextStyle.copyWith(
                color: appTheme.colorScheme.secondary,
              ),
            )
          : Text(
              optionName,
              style: WidgetConstants.appMenuOptionTextStyle,
            ),
    );
  }
}
