import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/ui/call_screen.dart';
import 'package:green_mode/core/constants/sub_app.dart';
import 'package:green_mode/core/core_providers.dart';
import 'package:green_mode/core/ui/apps_menu_screen.dart';
import 'package:green_mode/core/ui/main_menu_screen.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/ui/green_do_screen.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_details/activity_details_screen.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/ui/news_details/news_detail_screen.dart';
import 'package:green_mode/news/ui/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_details/podcast_details_screen.dart';
import 'package:green_mode/podcast/ui/podcast_screen.dart';

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
  static MaterialPageRoute callScreen(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.call;
    return MaterialPageRoute(builder: (context) => const CallScreen());
  }

  //green do
  static MaterialPageRoute greenDoScreen(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.greenDo;
    return MaterialPageRoute(builder: (context) => const GreenDoScreen());
  }

  static MaterialPageRoute activityDetailScreen(BuildContext context, Activity activity) =>
      MaterialPageRoute(builder: (context) => ActivityDetailsScreen(activity: activity));

  //podcast
  static MaterialPageRoute podcastScreen(BuildContext context, WidgetRef ref) {
    ref.read(currentSubAppLocationProvider.notifier).state = SubApp.podcast;
    return MaterialPageRoute(builder: (context) => const PodcastScreen());
  }

  static MaterialPageRoute podcastDetailScreen(BuildContext context, String podcastUrl) =>
      MaterialPageRoute(builder: (context) => PodcastDetailsScreen(podcastUrl: podcastUrl));

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
