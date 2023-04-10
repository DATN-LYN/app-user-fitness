import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../global/themes/app_colors.dart';
import '../../../type/widgets/program_tile_large.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ShadowWrapper(
            child: Column(
              children: [
                const Text(
                  '1290 Calories Burnt',
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <SplineSeries<SalesData, String>>[
                      SplineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData('Jan', 35),
                            SalesData('Feb', 28),
                            SalesData('Mar', 34),
                            SalesData('Apr', 32),
                            SalesData('May', 40)
                          ],
                          splineType: SplineType.cardinal,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Recently Workout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const ProgramTileLarge();
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
