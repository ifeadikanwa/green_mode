import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';

class DownloadPair extends Equatable {
  final FileSystemEntity file;
  final Download download;

  const DownloadPair({
    required this.file,
    required this.download,
  });

  @override
  List<Object?> get props => [
        file,
        download,
      ];
}
