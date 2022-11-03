import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/themed_expansion_tile.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:podcast_search/podcast_search.dart';

class PodcastBasicInfoScreen extends StatelessWidget {
  final Podcast podcast;

  const PodcastBasicInfoScreen({Key? key, required this.podcast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        // Center(
        //   child: Text(
        //     podcast.title ?? "Untitled",
        //     style: WidgetConstants.subHeadingTextStyle.copyWith(
        //       fontWeight: FontWeight.bold,
        //       color: appTheme.colorScheme.secondary,
        //     ),
        //   ),
        // ),

        //image expansion tile
        (podcast.image != null)
            ? ThemedExpansionTile(
                tileTitle: "View image",
                imageUrl: podcast.image!,
              )
            : const SizedBox(),

        //desc
        const Text(
          "Description",
          style: WidgetConstants.smallerSubHeadingTextStyle,
        ),
        const AddVerticalSpace(height: 8.0),
        Text(podcast.description ?? ""),
      ],
    );
  }
}
