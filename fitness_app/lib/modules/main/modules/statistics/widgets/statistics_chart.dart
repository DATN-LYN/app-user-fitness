import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({
    super.key,
    required this.data,
  });

  final List<GGetMyStatsData_getMyStats_items> data;

  @override
  Widget build(BuildContext context) {
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
              xValueMapper: (data, index) =>
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
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
