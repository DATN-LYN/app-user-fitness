import 'package:jiffy/jiffy.dart';

import '../gen/i18n.dart';

enum FilterRangeType {
  weekly(),
  monthly(),
  yearly();

  DateTime? startDate({int? month}) {
    switch (this) {
      case FilterRangeType.weekly:
        return Jiffy().startOf(Units.WEEK).dateTime;
      case FilterRangeType.monthly:
        return getFirstDayOfMonth(month ?? Jiffy().month);
      case FilterRangeType.yearly:
        return Jiffy().startOf(Units.YEAR).dateTime;
    }
  }

  DateTime? endDate({int? month}) {
    switch (this) {
      case FilterRangeType.weekly:
        return Jiffy().endOf(Units.WEEK).dateTime;
      case FilterRangeType.monthly:
        return getLastDayOfMonth(month ?? Jiffy().month);
      case FilterRangeType.yearly:
        return Jiffy().endOf(Units.YEAR).dateTime;
    }
  }

  String label(I18n i18n) {
    switch (this) {
      case FilterRangeType.weekly:
        return i18n.common_Weekly;
      case FilterRangeType.monthly:
        return i18n.common_Monthly;
      case FilterRangeType.yearly:
        return i18n.common_Yearly;
    }
  }

  String timeText(I18n i18n) {
    switch (this) {
      case FilterRangeType.weekly:
        return i18n.statistics_ThisWeek;
      case FilterRangeType.monthly:
        return i18n.statistics_ThisMonth;
      case FilterRangeType.yearly:
        return i18n.statistics_ThisMonth;
    }
  }

  DateTime getFirstDayOfMonth(int month) {
    final now = DateTime.now();
    return DateTime(now.year, month, 1);
  }

  DateTime getLastDayOfMonth(int month) {
    final now = DateTime.now();
    return DateTime(now.year, month + 1, 0);
  }

  List<String> xValuesChart(I18n i18n, {int? month}) {
    final now = DateTime.now();

    switch (this) {
      case FilterRangeType.weekly:
        return i18n.weekDays_;
      case FilterRangeType.monthly:
        final daysInMonth = DateTime(now.year, month ?? 1, 0).day;
        return List.generate(daysInMonth, (index) => (index + 1).toString());
      case FilterRangeType.yearly:
        return ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    }
  }

  int chartLength({int? month}) {
    final now = DateTime.now();

    switch (this) {
      case FilterRangeType.weekly:
        return 7;
      case FilterRangeType.monthly:
        return DateTime(now.year, month ?? 1, 0).day;
      case FilterRangeType.yearly:
        return 12;
    }
  }
}
