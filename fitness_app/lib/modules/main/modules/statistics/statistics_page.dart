import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/modules/main/modules/statistics/statistics_body_data.dart';
import 'package:fitness_app/modules/main/modules/statistics/statistics_chart.dart';
import 'package:fitness_app/modules/main/modules/statistics/statistics_recently_workout.dart';
import 'package:flutter/material.dart';

import '../../../../global/themes/app_colors.dart';

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
          RichText(
            text: const TextSpan(
              text: 'You have burnt ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey1,
              ),
              children: [
                TextSpan(
                  text: '1290 calories ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBold,
                  ),
                ),
                TextSpan(text: 'this month.'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'What a great value!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const StatisticsChart(),
          const SizedBox(height: 32),
          const StatisticsBodyData(),
          const SizedBox(height: 16),
          const Text(
            'Recently Workout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 32),
          const StatisticsRecentlyWorkout(),
        ],
      ),
    );
  }
}
