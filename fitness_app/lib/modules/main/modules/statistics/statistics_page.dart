import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/themes/app_colors.dart';
import 'widgets/month_picker_dialog.dart';
import 'widgets/statistics_body_data.dart';
import 'widgets/statistics_chart.dart';
import 'widgets/statistics_recently_workout.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  FilterRangeType selectedFilter = FilterRangeType.weekly;
  var req = GGetMyStatsReq(
    (b) => b
      ..vars.queryParams.limit = 10
      ..vars.queryParams.page = 1,
  );

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          if (isLogedIn)
            Row(
              children: [
                _filterItem(schedule: FilterRangeType.weekly),
                _filterItem(schedule: FilterRangeType.monthly),
                _filterItem(schedule: FilterRangeType.yearly),
              ],
            ),
          if (selectedFilter == FilterRangeType.monthly)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FormBuilderField<DateTime>(
                name: 'month',
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                ),
                builder: (field) {
                  return MonthPickerDialog(
                    onChanged: (selectedMonth) {
                      if (selectedMonth != null) {
                        field.didChange(selectedMonth);
                      }
                    },
                  );
                },
              ),
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
          Text(
            i18n.statistics_RecentWorkout,
            style: const TextStyle(
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

  Widget _filterItem({required FilterRangeType schedule}) {
    final isSelected = selectedFilter == schedule;
    final i18n = I18n.of(context)!;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: () {
            setState(() {
              selectedFilter = schedule;
            });
          },
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryBold
                : AppColors.primary.withOpacity(0.7),
          ),
          child: Text(
            schedule.label(i18n),
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
