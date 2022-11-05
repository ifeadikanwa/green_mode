import 'package:flutter/material.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerManager extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerManager({
    required String? audioUrl,
    required bool isRemoteFile,
  }) {
    if (audioUrl != null) {
      _init(audioUrl, isRemoteFile);
    }
  }

  AudioProgress audioProgress = const AudioProgress(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  );

  AudioButtonState audioButtonState = AudioButtonState.paused;

  void _init(
    String audioUrl,
    bool isRemoteFile,
  ) async {
    if (isRemoteFile) {
      await _audioPlayer.setUrl(audioUrl);
    } else {
      await _audioPlayer.setFilePath(
        audioUrl,
        initialPosition: Duration.zero,
        preload: true,
      );
    }

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        audioButtonState = AudioButtonState.loading;
        notifyListeners();
      } else if (!isPlaying) {
        audioButtonState = AudioButtonState.paused;
        notifyListeners();
      } else if (processingState != ProcessingState.completed) {
        audioButtonState = AudioButtonState.playing;
        notifyListeners();
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
        notifyListeners();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      audioProgress = audioProgress.copyWith(
        current: position,
      );
      notifyListeners();
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      audioProgress = audioProgress.copyWith(
        buffered: bufferedPosition,
      );
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      audioProgress = audioProgress.copyWith(
        total: totalDuration ?? Duration.zero,
      );
      notifyListeners();
    });
  }

  void play() {
    _audioPlayer.play();
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    notifyListeners();
  }

  void dispose() {
    _audioPlayer.dispose();
    notifyListeners();
  }
}
