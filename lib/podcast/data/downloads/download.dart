import 'package:equatable/equatable.dart';

class Download extends Equatable {
  final int? id;
  final String title;

  final String? podcastName;
  final String episodeDescription;

  final String? podcastUrl;

  final String? imageUrl;

  final String? audioUrl;

  final int? duration;

  final bool downloaded;

  final String filePath;

  Download({
    this.id,
    required this.title,
    this.podcastName,
    required this.episodeDescription,
    this.podcastUrl,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
    required this.downloaded,
    required this.filePath,
  });

  static const allColumns = [
    "id",
    "title",
    "podcastName",
    "episodeDescription",
    "podcastUrl",
    "imageUrl",
    "audioUrl",
    "duration",
    "downloaded",
    "filePath",
  ];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "podcastName": podcastName,
      "episodeDescription": episodeDescription,
      "podcastUrl": podcastUrl,
      "imageUrl": imageUrl,
      "audioUrl": audioUrl,
      "duration": duration,
      "downloaded": downloaded ? 1 : 0,
      "filePath": filePath,
    };
  }

  static Download fromMap({required Map<String, Object?> downloadMap}) {
    return Download(
        id: downloadMap["id"] as int?,
        title: downloadMap["title"] as String,
        podcastName: downloadMap["podcastName"] as String?,
        episodeDescription: downloadMap["episodeDescription"] as String,
        podcastUrl: downloadMap["podcastUrl"] as String?,
        imageUrl: downloadMap["imageUrl"] as String?,
        audioUrl: downloadMap["audioUrl"] as String?,
        duration: downloadMap["duration"] as int?,
        downloaded: downloadMap["downloaded"] == 1,
        filePath: downloadMap["filePath"] as String);
  }

  Download copyWith({
    int? id,
    String? title,
    String? podcastName,
    String? episodeDescription,
    String? podcastUrl,
    String? imageUrl,
    String? audioUrl,
    int? duration,
    bool? downloaded,
    String? filePath,
  }) {
    return Download(
      id: id ?? this.id,
      title: title ?? this.title,
      podcastName: podcastName ?? this.podcastName,
      episodeDescription: episodeDescription ?? this.episodeDescription,
      podcastUrl: podcastUrl ?? this.podcastUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      downloaded: downloaded ?? this.downloaded,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  String toString() {
    return "($title, $podcastName, $episodeDescription, $podcastUrl, $imageUrl, $audioUrl, $duration, $downloaded, $filePath)";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        podcastName,
        episodeDescription,
        podcastUrl,
        imageUrl,
        audioUrl,
        duration,
        downloaded,
        filePath,
      ];
}
