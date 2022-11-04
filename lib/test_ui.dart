import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/data/models/emission.dart';
import 'package:podcast_search/podcast_search.dart';

class TestUI extends ConsumerWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<List<Emission>> todaysEmission =
    //     ref.watch(todaysEmissionProvider);

    // return todaysEmission.when(
    //   data: (data) => Text(data.toString()),
    //   error: (error, stackTrace) {
    //     print(error);
    //,     return Text(error.toString());
    //   },
    //   loading: () => const LoadingIndicator(),
    // );
    testPodcast();

    return Container();
  }

  Future<void> testPodcast() async {
    final podcastSearcher = Search();

    SearchResult result = await podcastSearcher.search(
      "code",
      country: Country.UNITED_STATES,
      limit: 5,
    );

    result.items.forEach((result) {
      print("${result.trackName} -> ${result.feedUrl}");
    });

    Podcast podcast = await Podcast.loadFeed(url: result.items[0].feedUrl!);
  }
}
