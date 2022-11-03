import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';

class PodcastPlayerButton extends ConsumerWidget {
  final Color? iconColor;
  const PodcastPlayerButton({
    Key? key,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerManager = ref.watch(audioPlayerManagerProvider);

    switch (audioPlayerManager.audioButtonState) {
      case AudioButtonState.loading:
        return const LoadingIndicator();
      case AudioButtonState.paused:
        return IconButton(
          icon: Icon(
            Icons.play_arrow,
            color: iconColor,
          ),
          onPressed: () {
            audioPlayerManager.play();
          },
        );
      case AudioButtonState.playing:
        return IconButton(
          icon: Icon(
            Icons.pause,
            color: iconColor,
          ),
          onPressed: () {
            audioPlayerManager.pause();
          },
        );
      default:
        return const LoadingIndicator();
    }
  }
}
