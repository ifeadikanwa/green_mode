import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/search_bar.dart';
import 'package:green_mode/core/common_widgets/sub_app_bar.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/data/carbon_aware_service.dart';
import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/data/downloads/download_database_service.dart';
import 'package:green_mode/podcast/data/downloads/downloader_service.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_list/podcast_list_screen.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/mini_podcast_player.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_search_delegate.dart';

class PodcastScreen extends ConsumerWidget {


  const PodcastScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = Theme.of(context);

    return ScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //bar
          const SubAppBar(title: TextConstants.podcast),

          //search
          SearchBar(
            searchHint: "Find a podcast",
            searchDelegate: PodcastSearchDelegate(ref: ref),
          ),

          //player
          const AddVerticalSpace(height: 2.0),
          const MiniPodcastPlayer(),

          //download
          const AddVerticalSpace(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                AppRouter.downloadScreen(context),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Downloads",
                  style: WidgetConstants.subHeadingTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appTheme.colorScheme.secondary,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: appTheme.colorScheme.secondary,
                ),
              ],
            ),
          ),
          const ThemedDivider(),

          //chart
          const AddVerticalSpace(height: 16.0),
          Text(
            "Top Podcasts:",
            style: WidgetConstants.subHeadingTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          topPodcastListWidget(ref),
        ],
      ),
    );
  }

  Widget topPodcastListWidget(WidgetRef ref) {
    final topPodcasts = ref.watch(top10PodcastProvider);

    return topPodcasts.when(
      data: (topPodcastsResult) {
        return PodcastListScreen(podcastList: topPodcastsResult);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const LoadingIndicator(),
    );
  }

  
}
