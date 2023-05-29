import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../../global/data/models/statistics_filter_data.dart';
import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';

class StatisticsHelper {
  StatisticsHelper._();

  static List<double> getStatsData({
    required List<GGetMyStatsData_getMyStats_items> data,
    required StatisticsFilterData filter,
  }) {
    Map<int, double> mapData = {};
    List<int> days = [];
    switch (filter.rangeType) {
      case FilterRangeType.weekly:
        final startDay = Jiffy().startOf(Units.WEEK).dateTime.day + 1;
        days = List.generate(7, (index) => startDay + index);
        break;
      case FilterRangeType.monthly:
        days = FilterRangeType.monthly.days(month: filter.month);
        break;
      case FilterRangeType.yearly:
        days = FilterRangeType.yearly.days();
        break;
      default:
        break;
    }
    for (final day in days) {
      mapData[day] = 0;
    }
    final keys = mapData.keys.toList();
    for (final item in data) {
      if (filter.rangeType == FilterRangeType.yearly) {
        if (keys.contains(item.updatedAt!.month)) {
          mapData[item.updatedAt!.month] =
              mapData[item.updatedAt!.month]! + item.caloCount!;
        }
      } else {
        if (keys.contains(item.updatedAt!.day)) {
          mapData[item.updatedAt!.day] =
              mapData[item.updatedAt!.day]! + item.caloCount!;
        }
      }
    }
    return mapData.entries.map((e) => e.value).toList();
  }
}
