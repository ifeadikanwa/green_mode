import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/list_image_loader.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';
import 'package:green_mode/podcast/data/downloads/download_pair.dart';
import 'package:green_mode/podcast/data/downloads/downloader_service.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';
import 'package:podcast_search/podcast_search.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDownloads = ref.watch(downloadedPodcastsProvider);

    return ScreenContainer(
        child: Column(
      children: [
        //bar
        const InnerScreenAppBar(
          title: "Downloads",
        ),

        //download queue
        const AddVerticalSpace(height: 16.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              AppRouter.downloadQueueScreen(context),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Download queue",
                style: WidgetConstants.subHeadingTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
        const ThemedDivider(),

        //download list
        const AddVerticalSpace(height: 16.0),
        allDownloads.when(
          data: (allData) {
            // for (var element in allData) {
            //   print("${element.title}: ${element.downloaded}");
            // }

            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final DownloadPair podcastFile = allData[index];
                    return ListTile(
                      onTap: () {
                        ref.read(playingEpisodeProvider.notifier).state =
                            Episode(
                          guid: "0",
                          title: podcastFile.download.title,
                          description: podcastFile.download.episodeDescription,
                          imageUrl: podcastFile.download.imageUrl,
                          contentUrl: podcastFile.file.path,
                        );
                        ref.read(episodeIsRemoteFileProvider.notifier).state =
                            false;

                        Navigator.push(
                          context,
                          AppRouter.podcastPlayerScreen(context),
                        );
                      },
                      title: Text(podcastFile.download.title),
                    );
                  },
                  separatorBuilder: (context, index) => const ThemedDivider(),
                  itemCount: allData.length),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const LoadingIndicator(),
        ),
      ],
    ));
  }
}
