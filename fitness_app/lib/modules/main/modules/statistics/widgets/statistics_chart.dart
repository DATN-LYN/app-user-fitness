import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/extensions/double_extension.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/modules/main/modules/statistics/helper/statistics_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/data/models/statistics_filter_data.dart';
import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({
    super.key,
    required this.data,
    required this.filter,
  });

  final List<GGetMyStatsData_getMyStats_items> data;
  final StatisticsFilterData filter;

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  List<double> initialData = [];
  List<String> xValue = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          initialData = StatisticsHelper.getStatsData(
            data: widget.data,
            filter: widget.filter,
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var xValues = widget.filter.rangeType == FilterRangeType.monthly
        ? widget.filter.rangeType!
            .xValuesChart(i18n, month: widget.filter.month)
        : widget.filter.rangeType!.xValuesChart(i18n);

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
              dataSource: initialData,
              borderRadius: BorderRadius.circular(10),
              xValueMapper: (data, index) => xValues[index],
              yValueMapper: (data, index) => data,
            )
          ],
        ),
      ),
    );
  }
}
