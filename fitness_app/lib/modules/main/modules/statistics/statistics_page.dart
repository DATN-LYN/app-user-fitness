import 'package:fitness_app/global/enums/schedule_filter.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:flutter/material.dart';

import '../../../../global/themes/app_colors.dart';
import 'widgets/statistics_body_data.dart';
import 'widgets/statistics_chart.dart';
import 'widgets/statistics_recently_workout.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  ScheduleFilter selectedSchedule = ScheduleFilter.daily;

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
          const SizedBox(height: 8),
          Row(
            children: [
              _filterItem(schedule: ScheduleFilter.daily),
              _filterItem(schedule: ScheduleFilter.weekly),
              _filterItem(schedule: ScheduleFilter.monthly),
              _filterItem(schedule: ScheduleFilter.yearly),
            ],
          ),
          const SizedBox(height: 32),
          const StatisticsBodyData(),
          const SizedBox(height: 32),
          RichText(
            text: TextSpan(
              text: '${i18n.statistics_YouHaveBurnt} ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey1,
              ),
              children: [
                TextSpan(
                  text: '1290 ${i18n.statistics_Calories} ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBold,
                  ),
                ),
                TextSpan(text: '${i18n.statistics_ThisMonth}.'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            i18n.statistics_WhatAGreatValue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const StatisticsChart(),
          const SizedBox(height: 32),
          const Text(
            'Recently Workout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const StatisticsRecentlyWorkout(),
        ],
      ),
    );
  }

  Widget _filterItem({required ScheduleFilter schedule}) {
    final isSelected = selectedSchedule == schedule;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: () {
            setState(() {
              selectedSchedule = schedule;
            });
          },
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryBold
                : AppColors.primary.withOpacity(0.7),
          ),
          child: Text(
            schedule.value,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.grey1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
