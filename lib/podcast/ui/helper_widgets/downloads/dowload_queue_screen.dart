import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/list_image_loader.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/data/util/time_util.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';
import 'package:green_mode/podcast/data/downloads/download_database_service.dart';
import 'package:green_mode/podcast/data/downloads/downloader_service.dart';
import 'package:green_mode/podcast/data/podcast_providers.dart';

//todo: load downloads from database and enqueue here
class DownloadQueueScreen extends ConsumerStatefulWidget {
  const DownloadQueueScreen({Key? key}) : super(key: key);

  @override
  DownloadQueueScreenState createState() => DownloadQueueScreenState();
}

class DownloadQueueScreenState extends ConsumerState<DownloadQueueScreen> {
  final ReceivePort _port = ReceivePort();
  List<Map> downloadsListMaps = [];

  @override
  void initState() {
    super.initState();

    getTasks();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final allDownloads = ref.watch(allDownloadsProvider);
    final bestEmissionTime = ref.watch(bestEmissionToComeTimeProvider);

    return ScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //bar
          const InnerScreenAppBar(
            title: "Download queue",
          ),

          //schedule info
          //todo: Text with info-> download is scheduled for today at x
          bestEmissionTime.when(
            data: (bestTime) => Text(
              "Scheduled for ${TimeUtil.padTime(bestTime.hour)}:${TimeUtil.padTime(bestTime.minute)} ${(bestTime.hour >= 12) ? "PM" : "AM"}",
              style: WidgetConstants.smallerSubHeadingTextStyle.copyWith(
                color: appTheme.colorScheme.secondary,
              ),
            ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const LinearProgressIndicator(),
          ),

          //todo: list of files to be downloaded with trailing trash button to remove/delete
          allDownloads.when(
            data: (allData) {
             
              final downloads = allData
                  .where(
                    (data) => data.downloaded == false,
                  )
                  .toList();

              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final Download download = downloads[index];
                      return ListTile(
                        title: Text(download.title),
                        trailing: IconButton(
                            onPressed: () {
                              DownloaderService.addToDownloadQueue(
                                episodeTitle: download.title,
                                audioUrl: download.audioUrl,
                              );
                            },
                            icon: const Icon(Icons.download)),
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
      ),
    );
  }

  //Flutter downloader
  getTasks() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    getTasks?.forEach((task) {
      Map map = {};
      map[DownloaderService.status] = task.status;
      map[DownloaderService.progress] = task.progress;
      map[DownloaderService.taskId] = task.taskId;
      map[DownloaderService.filename] = task.filename;
      map[DownloaderService.savedDirectory] = task.savedDir;

      downloadsListMaps.add(map);
    });
    setState(() {});
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) async {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      var task = downloadsListMaps
          .where((element) => element[DownloaderService.taskId] == id);

      for (var element in task) {
        print("In Port method");

        //if download is complete update db record
        if (status == DownloadTaskStatus.complete) {
          print("DOWNLOAD COMPLETE");
          Download? downloadRecord =
              await DownloadDatabaseService.findDownloadWithFilePath(
                  element[DownloaderService.filename]);

          if (downloadRecord != null) {
            DownloadDatabaseService.updateDownload(
              downloadRecord.copyWith(downloaded: true),
            );
          }
        }

        //update local map
        element[DownloaderService.progress] = progress;
        element[DownloaderService.status] = status;
        setState(() {});
      }
    });
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
}
