import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/screen_title.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/sub_app.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/core_providers.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/core/ui/helper_widgets/app_menu_option.dart';

class AppsMenuScreen extends ConsumerWidget {
  const AppsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSubAppLocation = ref.watch(currentSubAppLocationProvider);

    return ScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //screen top bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ScreenTitle(title: TextConstants.appName),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const ThemedDivider(),

          //app options
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main menu
                const AddVerticalSpace(
                    height: WidgetConstants.appMenuOptionsSpacing),
                AppMenuOption(
                  optionName: TextConstants.mainMenu,
                  optionAction: () {
                    AppRouter.pushAndRemoveEveryOtherScreen(
                      context,
                      AppRouter.mainMenuScreen(context, ref),
                    );
                  },
                  isCurrentLocation: currentSubAppLocation == SubApp.mainMenu,
                ),

                //news
                const AddVerticalSpace(
                    height: WidgetConstants.appMenuOptionsSpacing),
                AppMenuOption(
                  optionName: TextConstants.news,
                  optionAction: () {
                    AppRouter.pushAndRemoveTillMainMenuScreen(
                      context,
                      AppRouter.newsScreen(context, ref),
                    );
                  },
                  isCurrentLocation: currentSubAppLocation == SubApp.news,
                ),

                //call
                const AddVerticalSpace(
                    height: WidgetConstants.appMenuOptionsSpacing),
                AppMenuOption(
                  optionName: TextConstants.call,
                  optionAction: () {
                    AppRouter.pushAndRemoveTillMainMenuScreen(
                      context,
                      AppRouter.callScreen(context, ref),
                    );
                  },
                  isCurrentLocation: currentSubAppLocation == SubApp.call,
                ),

                //green do
                const AddVerticalSpace(
                    height: WidgetConstants.appMenuOptionsSpacing),
                AppMenuOption(
                  optionName: TextConstants.greenDo,
                  optionAction: () {
                    AppRouter.pushAndRemoveTillMainMenuScreen(
                      context,
                      AppRouter.greenDoScreen(context, ref),
                    );
                  },
                  isCurrentLocation: currentSubAppLocation == SubApp.greenDo,
                ),

                //
                const AddVerticalSpace(
                    height: WidgetConstants.appMenuOptionsSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
