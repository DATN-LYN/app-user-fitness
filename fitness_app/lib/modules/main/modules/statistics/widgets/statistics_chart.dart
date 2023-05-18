import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/extensions/double_extension.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/data/models/statistics_filter_data.dart';
import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({
    super.key,
    required this.data,
    required this.filter,
  });

  final List<GGetMyStatsData_getMyStats_items> data;
  final StatisticsFilterData filter;
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var initialFilter = filter.rangeType;
    var xValues = initialFilter == FilterRangeType.monthly
        ? filter.rangeType!.xValuesChart(i18n, month: filter.month)
        : filter.rangeType!.xValuesChart(i18n);

    return ShadowWrapper(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * 0.9,
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (data, point, _, __, ___) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6,
                ),
                child: Text(
                  '${(point.y as double).toStringWithNoZero()} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            interval: 1,
          ),
          series: [
            ColumnSeries(
              dataSource: List.generate(
                  filter.rangeType!.chartLength(month: filter.month),
                  (index) =>
                      index < data.length ? data[index].caloCount ?? 0 : 0),
              borderRadius: BorderRadius.circular(10),
              xValueMapper: (data, index) => xValues[index],
              yValueMapper: (data, _) => data,
            )
          ],
        ),
      ),
    );
  }
}
