import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/routing/app_router.dart';

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
              AppRouter.callScren(context, ref),
            );
          },
          child: const Text("CALL"),
        ),
      ],
    ));
  }
}
