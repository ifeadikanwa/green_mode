import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_button.dart';

class MiniPodcastPlayer extends ConsumerWidget {
  const MiniPodcastPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = Theme.of(context);
    final episode = ref.watch(playingEpisodeProvider);

    return (episode == null)
        ? const SizedBox()
        : Container(
            color: appTheme.colorScheme.secondary,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        AppRouter.podcastPlayerScreen(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Now Playing",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            episode.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                WidgetConstants.listItemTitleTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const PodcastPlayerButton(
                  iconColor: Colors.black,
                ),
              ],
            ),
          );
  }
}
