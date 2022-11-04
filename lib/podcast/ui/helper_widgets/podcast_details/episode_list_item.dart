import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';
import 'package:green_mode/podcast/data/downloads/download_database_service.dart';
import 'package:green_mode/podcast/data/downloads/downloader_service.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:podcast_search/podcast_search.dart';

class EpisodeListItem extends ConsumerWidget {
  final Episode episode;

  const EpisodeListItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        ref.read(playingEpisodeProvider.notifier).state = episode;
        Navigator.push(
          context,
          AppRouter.podcastPlayerScreen(context),
        );
      },
      title: Text(
        episode.title,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: (episode.duration != null)
          ? Text("${episode.duration!.inMinutes} min")
          : const Text("- min"),
      trailing: IconButton(
        onPressed: () async {
          //todo: add downloads to database
          DownloadDatabaseService.createDownload(
            Download(
              title: episode.title,
              episodeDescription: episode.description,
              imageUrl: episode.imageUrl,
              audioUrl: episode.contentUrl,
              duration: episode.duration?.inMinutes,
              downloaded: false,
              filePath: await DownloaderService.getDownloadStorageLocation(episode.title),
            ),
          );

          print(
              "Downloads: ${await DownloadDatabaseService.getAllDownloads()}");
        },
        icon: const Icon(Icons.file_download_outlined),
      ),
    );
  }
}
