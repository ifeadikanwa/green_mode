import 'package:flutter/material.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_button_state.dart';
import 'package:green_mode/podcast/data/podcast_player/audio_progress.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  AudioPlayerManager({required String audioUrl}) {
    _init(audioUrl);
  }



  final progressNotifier = ValueNotifier<AudioProgress>(
    const AudioProgress(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  final buttonNotifier =
      ValueNotifier<AudioButtonState>(AudioButtonState.paused);



  late AudioPlayer _audioPlayer;

  void _init(String audioUrl) async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(audioUrl);

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = AudioButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = AudioButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = AudioButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = AudioProgress(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = AudioProgress(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = AudioProgress(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
