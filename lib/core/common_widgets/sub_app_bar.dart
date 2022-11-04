import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/screen_title.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/routing/app_router.dart';

class SubAppBar extends StatelessWidget {
  final String title;
  const SubAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScreenTitle(title: title),
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  AppRouter.appsMenuScreen(context),
                );
              },
            ),
          ],
        ),
        const ThemedDivider(),
      ],
    );
  }
}
