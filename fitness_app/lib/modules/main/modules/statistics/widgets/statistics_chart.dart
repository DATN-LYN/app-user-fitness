import 'package:adaptive_selector/adaptive_selector.dart';
import 'package:fitness_app/global/enums/chart_type.dart';
import 'package:fitness_app/global/extensions/double_extension.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/statistics/helper/statistics_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/data/models/statistics_filter_data.dart';
import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';

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
  ChartType chartType = ChartType.column;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    var xValues = widget.filter.rangeType!.xValuesChart(
      i18n,
      month: widget.filter.month,
      year: widget.filter.year,
    );

    final initialData = StatisticsHelper.getStatsData(
      data: widget.data,
      filter: widget.filter,
    );

    final options = ChartType.values
        .map(
          (e) => AdaptiveSelectorOption(
            label: '${i18n.chart_Chart} ${e.label(i18n)}',
            value: e,
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 270,
          height: 40,
          child: AdaptiveSelector(
            allowClear: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.white,
            ),
            initialOption: AdaptiveSelectorOption(
              label: '${i18n.chart_Chart} ${chartType.label(i18n)}',
              value: chartType,
            ),
            type: SelectorType.menu,
            options: options,
            onChanged: (option) {
              if (option != null) {
                setState(() {
                  chartType = option.value;
                });
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
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
            autoScrollingMode: AutoScrollingMode.start,
            autoScrollingDelta: 12,
          ),
          series: [
            if (chartType == ChartType.column)
              ColumnSeries(
                dataSource: initialData,
                borderRadius: BorderRadius.circular(10),
                xValueMapper: (data, index) => xValues[index],
                yValueMapper: (data, index) => data,
                color: AppColors.chartColor,
                width: 0.7,
                spacing: 0.3,
              ),
            if (chartType == ChartType.bar)
              BarSeries(
                dataSource: initialData,
                borderRadius: BorderRadius.circular(10),
                xValueMapper: (data, index) => xValues[index],
                yValueMapper: (data, index) => data,
                color: AppColors.chartColor,
                width: 0.7,
                spacing: 0.3,
              ),
            if (chartType == ChartType.line)
              LineSeries(
                dataSource: initialData,
                xValueMapper: (data, index) => xValues[index],
                yValueMapper: (data, index) => data,
                color: AppColors.chartColor,
              ),
            if (chartType == ChartType.stepline)
              StepLineSeries(
                dataSource: initialData,
                xValueMapper: (data, index) => xValues[index],
                yValueMapper: (data, index) => data,
                color: AppColors.chartColor,
              ),
          ],
        ),
      ],
    );
  }
}
