import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';

class MainMenuOption extends StatelessWidget {
  final String name;
  final IconData icon;
  final void Function() onTap;
  const MainMenuOption({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: appTheme.colorScheme.secondary,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 50.0,
              ),
              const AddVerticalSpace(height: 4.0),
              Text(
                name,
                style: WidgetConstants.subHeadingTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
