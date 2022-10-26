import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/ui/call_screen.dart';
import 'package:green_mode/core/constants/sub_app.dart';
import 'package:green_mode/core/core_providers.dart';
import 'package:green_mode/core/ui/apps_menu_screen.dart';
import 'package:green_mode/core/ui/main_menu_screen.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/ui/news_details/news_detail_screen.dart';
import 'package:green_mode/news/ui/news_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  //app
  static MaterialPageRoute mainMenuScreen(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.mainMenu;
    return MaterialPageRoute(builder: (context) => const MainMenuScreen());
  }

  static MaterialPageRoute appsMenuScreen(BuildContext context) =>
      MaterialPageRoute(builder: (context) => const AppsMenuScreen());

  //news
  static MaterialPageRoute newsScreen(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.news;
    return MaterialPageRoute(builder: (context) => const NewsScreen());
  }

  static MaterialPageRoute newsDetailScreen(BuildContext context, News news) =>
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news));

  //call
  static MaterialPageRoute callScren(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.call;
    return MaterialPageRoute(builder: (context) => const CallScreen());
  }

  static void pushAndRemoveEveryOtherScreen(
    BuildContext context,
    MaterialPageRoute newRoute,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      newRoute,
      (route) => false,
    );
  }

   static void pushAndRemoveTillMainMenuScreen(
    BuildContext context,
    MaterialPageRoute newRoute,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      newRoute,
      (route) => route.isFirst,
    );
  }
}
