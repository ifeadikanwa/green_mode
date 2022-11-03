import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';

class EpisodeListItem extends StatelessWidget {
  final Episode episode;

  const EpisodeListItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        episode.title,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: (episode.duration != null)
          ? Text("${episode.duration!.inMinutes} min")
          : const Text("- min"),
      trailing: const Icon(Icons.play_circle_outline),
    );
  }
}
