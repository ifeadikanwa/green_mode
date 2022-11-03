import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:green_mode/podcast/data/podcast_service.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  PodcastSearchDelegate({required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final location = ref.watch(locationProvider);

    // final results =
    // PodcastService.performSearch(query: query, location: location);

    return FutureBuilder<SearchResult>(
        future: PodcastService.performSearch(query: query, location: location),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.items.length,
              itemBuilder: (context, index) {
                var podcast = snapshot.data!.items[index];

                return ListTile(
                  title: Text(podcast.trackName ?? "Untitled"),
                  subtitle: (podcast.artistName != null)
                      ? Text("By ${podcast.trackName}")
                      : const Text("By unknown"),
                  onTap: () {
                    Navigator.push(
                      context,
                      AppRouter.podcastDetailScreen(
                          context, podcast.feedUrl ?? ""),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const ThemedDivider(),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                LoadingIndicator(),
              ],
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
