import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_player_notifier.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress_notifier.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_search/podcast_search.dart';

final top10PodcastProvider = FutureProvider<SearchResult>((ref) {
  final location = ref.watch(locationProvider);

  return Search().charts(
    limit: 10,
    country: location.country,
  );
});

final podcastDetailsProvider =
    FutureProvider.autoDispose.family<Podcast, String>((ref, podcastUrl) async {
  return Podcast.loadFeed(url: podcastUrl);
});

final audioButtonStateProvider = StateProvider<AudioButtonState>((ref) {
  final audioPlayerState = ref.watch(audiouPlayerStateStreamProvider);

  audioPlayerState.whenData((playerState) {
    final isPlaying = playerState.playing;
    print("is playing = $isPlaying");

    final processingState = playerState.processingState;
    print("Processing state = $processingState");

    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      print("decided loading");
      return AudioButtonState.loading;
    } else if (!isPlaying) {
      print("decided pause");
      return AudioButtonState.paused;
    } else {
      print("decided playing");
      return AudioButtonState.playing;
    }
  });

  return AudioButtonState.paused;
});

final audioProgressNotifierProvider =
    StateNotifierProvider<AudioProgressNotifier, AudioProgress>((ref) {
  final AudioProgressNotifier audioProgressNotifier = AudioProgressNotifier();

  // ref.listen(audioPlayerNotifierProvider,
  //     (previousAudioPlayer, newAudioPlayer) {
  //   newAudioPlayer.positionStream.listen((position) {
  //     audioProgressNotifier.updateCurrentPosition(position);
  //   });

  //   newAudioPlayer.bufferedPositionStream.listen((position) {
  //     audioProgressNotifier.updateBufferedPosition(position);
  //   });

  //   newAudioPlayer.durationStream.listen((position) {
  //     audioProgressNotifier.updateTotalPosition(position ?? Duration.zero);
  //   });
  // });

  return audioProgressNotifier;
});

final audioPlayerNotifierProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayer>((ref) {
  final audioUrl = ref.watch(audioUrlProvider);

  return AudioPlayerNotifier(audioUrl: audioUrl);
});

final audioUrlProvider = StateProvider<String>(
    (ref) => "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");

final audiouPlayerStateStreamProvider = StreamProvider<PlayerState>((ref) {
  final audioPlayer = ref.watch(audioPlayerNotifierProvider);

  return audioPlayer.playerStateStream;
});
