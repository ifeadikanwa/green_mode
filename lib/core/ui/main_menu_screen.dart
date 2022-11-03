import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_screen.dart';
import 'package:green_mode/podcast/ui/podcast_screen.dart';
import 'package:green_mode/test_ui.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              AppRouter.newsScreen(context, ref),
            );
          },
          child: const Text("NEWS"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              AppRouter.callScreen(context, ref),
            );
          },
          child: const Text("CALL"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TestUI()));
          },
          child: const Text("TEST UI"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              AppRouter.greenDoScreen(context, ref),
            );
          },
          child: const Text("GREEN DO"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              AppRouter.podcastScreen(context, ref),
            );
          },
          child: const Text("PODCAST"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context, AppRouter.podcastScreen(context, ref));
          },
          child: const Text("PODCAST PLAYER"),
        ),
      ],
    ));
  }
}
