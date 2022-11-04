import 'date_time_extension.dart';

class TimeUtil {
  //get start of day time in utc
  static DateTime getStartOfDayUTCTime() {
    final currentTime = DateTime.now();

    final DateTime startOfDayLocal = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
    );

    final DateTime startOfDayUTC = startOfDayLocal.toUtc();

    return startOfDayUTC;
  }

  static DateTime getEndOfDayUTCTime() {
    final currentTime = DateTime.now();

    final DateTime endOfDayLocal = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      23,
      55,
    );

    final DateTime endOfDayUTC = endOfDayLocal.toUtc();

    return endOfDayUTC;
  }

  static DateTime getCurrentUTCTime() {
    final currentTimeRawUTC = DateTime.now().toUtc();
    final currentTimeRounded = currentTimeRawUTC.roundDownUTC();

    return currentTimeRounded;
  }

  static String convertUTCTimeToCarbonAwareApiTimeString(DateTime time) {
    //example: 2022-10-31T22%3A35%3A00Z
    return "${padTime(time.year)}-${padTime(time.month)}-${padTime(time.day)}T${padTime(time.hour)}%3A${padTime(time.minute)}%3A${padTime(time.second)}Z";
  }

  static DateTime convertCarbonAwareApiTimeStringToLocalTime(
    String timeString,
  ) {
    //example: 2022-10-31T23:55:00+00:00
    return DateTime.parse(timeString).toLocal();
  }

  static String padTime(int time) {
    return time.toString().padLeft(2, "0");
  }
}
