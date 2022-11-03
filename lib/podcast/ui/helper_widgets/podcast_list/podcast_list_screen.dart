import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/common_widgets/themed_scrollbar.dart';
import 'package:green_mode/podcast/ui/helper_widgets/podcast_list/podcast_list_item.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastListScreen extends StatelessWidget {
  final SearchResult podcastList;

  const PodcastListScreen({Key? key, required this.podcastList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ThemedScrollbar(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return PodcastListItem(podcastItem: podcastList.items[index]);
            },
            separatorBuilder: (context, index) => const ThemedDivider(),
            itemCount: podcastList.items.length),
      ),
    );
  }
}
