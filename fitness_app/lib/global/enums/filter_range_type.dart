import 'package:jiffy/jiffy.dart';

import '../gen/i18n.dart';

enum FilterRangeType {
  weekly(),
  monthly(),
  yearly();

  DateTime? startDate() {
    switch (this) {
      case FilterRangeType.weekly:
        return Jiffy().startOf(Units.WEEK).dateTime;
      case FilterRangeType.monthly:
        return Jiffy().startOf(Units.MONTH).dateTime;
      case FilterRangeType.yearly:
        return Jiffy().startOf(Units.YEAR).dateTime;
    }
  }

  DateTime? endDate() {
    switch (this) {
      case FilterRangeType.weekly:
        return Jiffy().endOf(Units.WEEK).dateTime;
      case FilterRangeType.monthly:
        return Jiffy().endOf(Units.MONTH).dateTime;
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
}
