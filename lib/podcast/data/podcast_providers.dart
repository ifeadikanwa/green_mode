import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';
import 'package:green_mode/podcast/data/downloads/download_database_service.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_player_manager.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
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

final playingEpisodeProvider = StateProvider<Episode?>((ref) => null);

final audioPlayerManagerProvider =
    ChangeNotifierProvider<AudioPlayerManager>((ref) {
  return AudioPlayerManager(
      audioUrl: ref.watch(playingEpisodeProvider)?.contentUrl);
});

final allDownloadsProvider = FutureProvider.autoDispose<List<Download>>(
    (ref) => DownloadDatabaseService.getAllDownloads());
