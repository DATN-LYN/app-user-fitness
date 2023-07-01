import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/enums/filter_range_type.dart';
import '../../../../../global/gen/i18n.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/fitness_empty.dart';
import '../../../../../global/widgets/login_panel.dart';
import 'statistics_overview.dart';

class NotLoginStatistics extends StatelessWidget {
  const NotLoginStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Column(
      children: [
        const LoginPanel(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            children: [
              const SizedBox(height: 16),
              const UnLoginStatisticsFilter(),
              const SizedBox(height: 16),
              const StatisticsOverview(),
              const SizedBox(height: 16),
              const UnloginStatisticsChart(),
              const SizedBox(height: 16),
              Text(
                i18n.statistics_RecentWorkout,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              FitnessEmpty(
                title: i18n.common_Oops,
                message: i18n.common_YouHaveToLogin,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UnLoginStatisticsFilter extends StatelessWidget {
  const UnLoginStatisticsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    return Row(
      children: [
        ...FilterRangeType.values.map(
          (rangeType) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilledButton(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.7),
                  ),
                  child: Text(
                    rangeType.label(i18n),
                    style: const TextStyle(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class UnloginStatisticsChart extends StatelessWidget {
  const UnloginStatisticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        axisLine: const AxisLine(width: 0),
        interval: 1,
      ),
      series: [
        ColumnSeries(
          dataSource: [0, 0, 0, 0, 0, 0, 0],
          borderRadius: BorderRadius.circular(10),
          xValueMapper: (data, index) => index + 1,
          yValueMapper: (data, index) => data,
          color: AppColors.chartColor,
          width: 0.3,
          spacing: 0.2,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              color: AppColors.grey1,
            ),
          ),
        ),
      ],
    );
  }
}
