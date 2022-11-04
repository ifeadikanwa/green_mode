import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloaderService {
  static const status = "status";
  static const progress = "progress";
  static const taskId = "id";
  static const filename = "filename";
  static const savedDirectory = "savedDirectory";

  static Future<String> getDownloadStorageLocation(String filename) async {
    var path = await getApplicationDocumentsDirectory().then(
      (value) => "${value.path}/downloads/${filename.replaceAll(" ", "_")}",
    );

    var downloadDir = await Directory(path).create(recursive: true);


    return downloadDir.path;
  }

  static void addToDownloadQueue(
      {required String episodeTitle, required String? audioUrl}) async {
    if (audioUrl != null) {
      final String downloadStoragePath =
          await getDownloadStorageLocation(episodeTitle);

      final taskId = await FlutterDownloader.enqueue(
        fileName: episodeTitle,
        url: audioUrl,
        savedDir: downloadStoragePath,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            false, // click on notification to open downloaded file (for Android)
      );
    }
  }

  static Future<List<Map>> getDownloadTasks() async {
    List<Map> downloadsListMaps = [];

    return downloadsListMaps;
  }
}
