import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({
    super.key,
    required this.data,
    required this.filter,
  });

  final List<GGetMyStatsData_getMyStats_items> data;
  final FilterRangeType filter;
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var xValues = [];
    if (filter == FilterRangeType.monthly) {
      xValues = filter.xValuesChart(i18n, month: 2);
    } else {
      xValues = filter.xValuesChart(i18n);
    }

    return ShadowWrapper(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * 0.9,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: [
            ColumnSeries(
              dataSource: List.generate(
                  7,
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
