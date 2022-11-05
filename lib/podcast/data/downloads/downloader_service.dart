import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloaderService {
  static const status = "status";
  static const progress = "progress";
  static const taskId = "id";
  static const filename = "filename";
  static const savedDirectory = "savedDirectory";

  static Future<Directory> getDownloadStorageLocation() async {
    var path = await getExternalStorageDirectory().then(
      (value) => "${value?.path}/green_mode_downloads",
    );

    var downloadDir = await Directory(path).create(recursive: true);

    print(downloadDir.path);

    return downloadDir;
  }

  static void addToDownloadQueue(
      {required String episodeTitle, required String? audioUrl}) async {
    if (audioUrl != null) {
      final Directory downloadStoragePath = await getDownloadStorageLocation();

      final taskId = await FlutterDownloader.enqueue(
        fileName: "${episodeTitle.trim()}.mp3",
        url: audioUrl,
        savedDir: downloadStoragePath.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            false, // click on notification to open downloaded file (for Android)
      );
    }
  }
}
