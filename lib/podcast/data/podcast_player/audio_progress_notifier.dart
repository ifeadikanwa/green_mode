import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';

class AudioProgressNotifier extends StateNotifier<AudioProgress> {
  AudioProgressNotifier()
      : super(
          const AudioProgress(
            current: Duration.zero,
            buffered: Duration.zero,
            total: Duration.zero,
          ),
        );

  updateCurrentPosition(Duration newCurrentPosition) {
    state = state.copyWith(current: newCurrentPosition);
  }

  updateBufferedPosition(Duration newBufferedPosition) {
    state = state.copyWith(buffered: newBufferedPosition);
  }

  updateTotalPosition(Duration newTotalPosition) {
    state = state.copyWith(total: newTotalPosition);
  }
}
