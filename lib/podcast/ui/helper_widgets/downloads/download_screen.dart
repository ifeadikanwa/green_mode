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
import 'package:green_mode/podcast/data/podcast_providers.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDownloads = ref.watch(allDownloadsProvider);

    return ScreenContainer(
        child: Column(
      children: [
        //bar
        const InnerScreenAppBar(),

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
            final downloads = allData
                .where(
                  (data) => data.downloaded == true,
                )
                .toList();

            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final Download download = downloads[index];
                    return ListTile(
                      title: Text(download.title),
                    );
                  },
                  separatorBuilder: (context, index) => const ThemedDivider(),
                  itemCount: downloads.length),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const LoadingIndicator(),
        ),
      ],
    ));
  }
}
