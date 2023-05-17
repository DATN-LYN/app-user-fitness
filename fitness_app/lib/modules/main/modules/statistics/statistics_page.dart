import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/modules/main/modules/statistics/widgets/statistics_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/graphql/client.dart';
import '../../../../global/themes/app_colors.dart';
import 'widgets/statistics_body_data.dart';
import 'widgets/statistics_chart.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  String? timeText;
  var selectedFilter = FilterRangeType.weekly;

  var key = GlobalKey();
  var getMyStatsReq = GGetMyStatsReq(
    (b) => b
      ..requestId = '@getMyStatsRequestId'
      ..vars.queryParams.limit = 10
      ..vars.queryParams.page = 1,
  );

  void handleFilterChange(GGetMyStatsReq newReq, FilterRangeType filter) {
    setState(
      () {
        selectedFilter = filter;
        getMyStatsReq = getMyStatsReq.rebuild((b) => b
          ..vars.queryParams.filters =
              newReq.vars.queryParams.filters?.toBuilder());
        // key = GlobalKey();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);
    final client = ref.watch(appClientProvider);

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: Operation(
          client: client,
          operationRequest: getMyStatsReq,
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
                StatisticsFilter(
                  request: GGetMyStatsReq(
                    (b) => b
                      ..vars.queryParams =
                          getMyStatsReq.vars.queryParams.toBuilder(),
                  ),
                  onChanged: (getMyStatsReq, selectedFilter) =>
                      handleFilterChange(getMyStatsReq, selectedFilter),
                ),
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
                    filter: selectedFilter,
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
                // if (isLogedIn)
                //   const StatisticsRecentlyWorkout()
                // else
                //   FitnessEmpty(
                //     title: i18n.common_Oops,
                //     message: i18n.common_YouHaveToLogin,
                //   ),
                const SizedBox(height: 16),
              ],
            );
          }),
    );
  }
}
