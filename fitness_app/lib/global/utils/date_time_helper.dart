class DateTimeHelper {
  DateTimeHelper._();

  static String totalDurationFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  // static DateTime getFirstDateOfTheWeek(DateTime dateTime) {
  //   return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  // }

  // static DateTime getLastDateOfTheWeek(DateTime dateTime) {
  //   return dateTime
  //       .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  // }
}
