import 'package:built_collection/built_collection.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/global/widgets/fitness_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/graphql/client.dart';
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
  String? timeText;

  var req = GGetMyStatsReq(
    (b) => b
      ..requestId = '@getMyStatsRequestId'
      ..vars.queryParams.limit = 10
      ..vars.queryParams.page = 1,
  );

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);
    final client = ref.watch(appClientProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: Operation(
          client: client,
          operationRequest: req,
          builder: (context, response, error) {
            final data = response?.data;
            final stats = data?.getMyStats.items?.toList();
            final calo =
                stats?.map((e) => e.caloCount).reduce((a, b) => a! + b!);
            final duration =
                stats?.map((e) => e.durationCount).reduce((a, b) => a! + b!);
            final program =
                stats?.map((e) => e.programCount).reduce((a, b) => a! + b!);

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (isLogedIn) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _filterItem(filter: FilterRangeType.weekly),
                      _filterItem(filter: FilterRangeType.monthly),
                      _filterItem(filter: FilterRangeType.yearly),
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
                ],
                StatisticsBodyData(
                  duration: duration ?? 0,
                  programs: program ?? 0,
                  exercises: 0,
                ),
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
                        text: isLogedIn
                            ? '$calo ${i18n.statistics_Calories} '
                            : '0 ${i18n.statistics_Calories} ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBold,
                        ),
                      ),
                      TextSpan(
                          text: '${timeText ?? i18n.statistics_ThisWeek}.'),
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
                if (stats != null && stats.isNotEmpty)
                  StatisticsChart(
                    data: stats,
                  ),
                const SizedBox(height: 32),
                Text(
                  i18n.statistics_RecentWorkout,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                if (isLogedIn)
                  const StatisticsRecentlyWorkout()
                else
                  FitnessEmpty(
                    title: i18n.common_Oops,
                    message: i18n.common_YouHaveToLogin,
                  ),
                const SizedBox(height: 16),
              ],
            );
          }),
    );
  }

  Widget _filterItem({required FilterRangeType filter}) {
    final isSelected = selectedFilter == filter;
    final i18n = I18n.of(context)!;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: () {
            final newFilters = req.vars.queryParams.filters?.toList() ?? [];

            setState(() {
              selectedFilter = filter;
              timeText = filter.timeText(i18n);
            });

            newFilters.addAll(
              [
                GFilterDto(
                  (b) => b
                    ..data = selectedFilter.startDate().toString()
                    ..field = 'UserStatistics.updatedAt'
                    ..operator = GFILTER_OPERATOR.gt,
                ),
                GFilterDto(
                  (b) => b
                    ..data = selectedFilter.endDate().toString()
                    ..field = 'UserStatistics.updatedAt'
                    ..operator = GFILTER_OPERATOR.lt,
                ),
              ],
            );

            req = req.rebuild(
                (p0) => p0..vars.queryParams.filters = ListBuilder(newFilters));
          },
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryBold
                : AppColors.primary.withOpacity(0.7),
          ),
          child: Text(
            filter.label(i18n),
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
