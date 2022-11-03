import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_player_manager.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_button.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_player/podcast_player_progress_bar.dart';

class PodcastPlayerScreen extends StatefulWidget {
  final String audioUrl;

  const PodcastPlayerScreen({Key? key, required this.audioUrl})
      : super(key: key);

  @override
  State<PodcastPlayerScreen> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  late final AudioPlayerManager audioPlayerManager;

  @override
  void initState() {
    super.initState();
    audioPlayerManager = AudioPlayerManager(audioUrl: widget.audioUrl);
  }

  @override
  void dispose() {
    audioPlayerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        child: Column(
      children: [
        ValueListenableBuilder<AudioProgress>(
          valueListenable: audioPlayerManager.progressNotifier,
          builder: (_, value, __) {
            return ProgressBar(
              progress: value.current,
              buffered: value.buffered,
              total: value.total,
              onSeek: audioPlayerManager.seek,
            );
          },
        ),
        ValueListenableBuilder<AudioButtonState>(
            valueListenable: audioPlayerManager.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case AudioButtonState.loading:
                  return const LoadingIndicator();
                case AudioButtonState.paused:
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      audioPlayerManager.play();
                    },
                  );
                case AudioButtonState.playing:
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      audioPlayerManager.pause();
                    },
                  );
              }
            }),
      ],
    ));
  }
}
