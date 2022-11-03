import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';

class PodcastPlayerButton extends ConsumerWidget {
  const PodcastPlayerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch(audioButtonStateProvider);
    final audioPlayer = ref.watch(audioPlayerNotifierProvider);

    

    switch (buttonState) {
      case AudioButtonState.loading:
        return const LoadingIndicator();
      case AudioButtonState.playing:
        return IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            print("PLAY");
            audioPlayer.pause();
          },
        );
      case AudioButtonState.paused:
        return IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {
            print("PAUSE");
            audioPlayer.play();
          },
        );
    }
  }
}
