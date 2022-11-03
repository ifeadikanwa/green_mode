import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_player_manager.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_button.dart';

class PodcastPlayerScreen extends ConsumerWidget {
  const PodcastPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = Theme.of(context);
    final audioPlayerManager = ref.watch(audioPlayerManagerProvider);
    final episode = ref.watch(playingEpisodeProvider);

    return ScreenContainer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const InnerScreenAppBar(),
        (episode != null && episode.imageUrl != null)
            ? CachedNetworkImage(imageUrl: episode.imageUrl!)
            : const SizedBox(),
        const AddVerticalSpace(height: 16.0),
        (episode != null)
            ? Text(
                episode.title,
                style: WidgetConstants.smallerSubHeadingTextStyle,
                softWrap: true,
                textAlign: TextAlign.center,
              )
            : const SizedBox(),
        (episode != null)
            ? Text(
                episode.description,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            : const SizedBox(),
        const AddVerticalSpace(height: 16.0),
        ProgressBar(
          progressBarColor: appTheme.colorScheme.secondary,
          progress: audioPlayerManager.audioProgress.current,
          buffered: audioPlayerManager.audioProgress.buffered,
          total: audioPlayerManager.audioProgress.total,
          onSeek: audioPlayerManager.seek,
        ),
        const PodcastPlayerButton(),
        const AddVerticalSpace(height: 16.0),
      ],
    ));
  }

  // Widget getAudioButton(
  //   AudioButtonState audioButtonState,
  //   AudioPlayerManager audioPlayerManager,
  // ) {
  //   switch (audioButtonState) {
  //     case AudioButtonState.loading:
  //       return const LoadingIndicator();
  //     case AudioButtonState.paused:
  //       return IconButton(
  //         icon: const Icon(Icons.play_arrow),
  //         onPressed: () {
  //           audioPlayerManager.play();
  //         },
  //       );
  //     case AudioButtonState.playing:
  //       return IconButton(
  //         icon: const Icon(Icons.pause),
  //         onPressed: () {
  //           audioPlayerManager.pause();
  //         },
  //       );
  //   }
  // }
}
