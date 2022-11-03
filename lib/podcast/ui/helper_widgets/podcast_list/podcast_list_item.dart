import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastListItem extends StatelessWidget {
  final Item podcastItem;

  const PodcastListItem({Key? key, required this.podcastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //on tap set podcast url and navigate
      onTap: () {
        Navigator.push(
          context,
          AppRouter.podcastDetailScreen(context, podcastItem.feedUrl ?? ""),
        );
      },

      //padding
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              podcastItem.trackName ?? "Untitled",
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: WidgetConstants.listItemTitleTextStyle,
            ),
            const AddVerticalSpace(height: 6.0),
            Text(
              podcastItem.artistName ?? "Unknown",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
