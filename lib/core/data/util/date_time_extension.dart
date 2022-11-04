extension DateTimeExtension on DateTime {
  DateTime roundDownUTC({Duration delta = const Duration(minutes: 5)}) {
    return DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds,
      isUtc: true,
    );
  }
}
