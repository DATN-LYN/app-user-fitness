import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../global/enums/filter_range_type.dart';

part 'statistics_filter_data.freezed.dart';

@freezed
class StatisticsFilterData with _$StatisticsFilterData {
  const factory StatisticsFilterData([
    FilterRangeType? rangeType,
    DateTime? startDate,
    DateTime? endDate,
  ]) = _StatisticsFilterData;
}
