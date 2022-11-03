import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier({required String audioUrl}) : super(AudioPlayer()) {
    _initializeAudioPlayer(audioUrl);
  }

  _initializeAudioPlayer(String audioUrl) async {
    await state.setUrl(audioUrl);
  }

  playAudio() {
    state.play();
  }

  pauseAudio() {
    state.pause();
  }
}
