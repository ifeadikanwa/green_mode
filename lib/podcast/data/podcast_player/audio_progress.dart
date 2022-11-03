class AudioProgress {
  final Duration current;
  final Duration buffered;
  final Duration total;

  const AudioProgress({
    required this.current,
    required this.buffered,
    required this.total,
  });

  AudioProgress copyWith({
    Duration? current,
    Duration? buffered,
    Duration? total,
  }) {
    return AudioProgress(
      current: current ?? this.current,
      buffered: buffered ?? this.buffered,
      total: total ?? this.total,
    );
  }
}
