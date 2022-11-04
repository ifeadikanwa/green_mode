import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_horizontal_space.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/sub_app_bar.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/core/ui/helper_widgets/main_menu_option.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_screen.dart';
import 'package:green_mode/podcast/ui/podcast_screen.dart';
import 'package:green_mode/test_ui.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = Theme.of(context);

    return ScreenContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          TextConstants.appName.toUpperCase(),
          style: WidgetConstants.headingTextStyle
              .copyWith(color: appTheme.colorScheme.secondary),
        ),
        const ThemedDivider(),
        const AddVerticalSpace(height: 16.0),

        //utilities
        const Text(
          "Utilities",
          style: WidgetConstants.appMenuOptionTextStyle,
        ),

        const AddVerticalSpace(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MainMenuOption(
              name: TextConstants.greenDo,
              icon: Icons.check,
              onTap: () => Navigator.push(
                context,
                AppRouter.greenDoScreen(context, ref),
              ),
            ),
            const AddHorizontalSpace(width: 16.0),
            MainMenuOption(
              name: TextConstants.call,
              icon: Icons.call_outlined,
              onTap: () => Navigator.push(
                context,
                AppRouter.callScreen(context, ref),
              ),
            ),
          ],
        ),
        const AddVerticalSpace(height: 16.0),

        //entertainment
        const Text(
          "Entertainment",
          style: WidgetConstants.appMenuOptionTextStyle,
        ),
        const AddVerticalSpace(height: 8.0),
        Row(
          children: [
            MainMenuOption(
              name: TextConstants.news,
              icon: Icons.newspaper_outlined,
              onTap: () => Navigator.push(
                context,
                AppRouter.newsScreen(context, ref),
              ),
            ),
            const AddHorizontalSpace(width: 16.0),
            MainMenuOption(
              name: TextConstants.podcast,
              icon: Icons.headset_outlined,
              onTap: () => Navigator.push(
                context,
                AppRouter.podcastScreen(context, ref),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
