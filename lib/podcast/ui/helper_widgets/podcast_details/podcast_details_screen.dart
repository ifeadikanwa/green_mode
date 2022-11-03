import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_details/episode_list_item.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_details/podcast_basic_info_screen.dart';

class PodcastDetailsScreen extends ConsumerWidget {
  final String podcastUrl;
  const PodcastDetailsScreen({Key? key, required this.podcastUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcast = ref.watch(podcastDetailsProvider(podcastUrl));

    return podcast.when(
      data: (data) {
        return ScreenContainer(
          child: Column(
            children: [
              //bar
              InnerScreenAppBar(
                title: data.title ?? "Untitled",
              ),

              //details
              (data.episodes == null)
                  //no episodes to show
                  ? Expanded(child: PodcastBasicInfoScreen(podcast: data))
                  //episodes to show
                  : Expanded(
                      child: ListView.separated(
                        itemCount: data.episodes!.length,
                        itemBuilder: (context, index) {
                          //first episode
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PodcastBasicInfoScreen(podcast: data),
                                const AddVerticalSpace(height: 16.0),
                                const Text(
                                  "Episodes",
                                  style: WidgetConstants
                                      .smallerSubHeadingTextStyle,
                                ),
                                EpisodeListItem(episode: data.episodes![index])
                              ],
                            );
                          }
                          //other episodes
                          else {
                            return EpisodeListItem(
                                episode: data.episodes![index]);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const ThemedDivider(),
                      ),
                    ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          LoadingIndicator(),
        ],
      ),
    );
  }
}
