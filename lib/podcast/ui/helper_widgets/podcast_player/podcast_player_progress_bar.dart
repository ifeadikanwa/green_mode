import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';

class PodcastPlayerProgressBar extends ConsumerWidget {
  const PodcastPlayerProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressBarValue = ref.watch(audioProgressNotifierProvider);

    return ProgressBar(
      progress: progressBarValue.current,
      total: progressBarValue.total,
      buffered: progressBarValue.buffered,
    );
  }
}
