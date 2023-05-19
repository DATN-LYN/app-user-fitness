import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:fitness_app/global/data/models/statistics_filter_data.dart';
import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/global/widgets/fitness_error.dart';
import 'package:fitness_app/modules/main/modules/statistics/widgets/statistics_filter.dart';
import 'package:fitness_app/modules/main/modules/statistics/widgets/statistics_recently_workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/graphql/client.dart';
import '../../../../global/widgets/fitness_empty.dart';
import 'widgets/statistics_body_data.dart';
import 'widgets/statistics_chart.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  var filterData =
      const StatisticsFilterData(rangeType: FilterRangeType.weekly);

  var key = GlobalKey();
  var getMyStatsReq = GGetMyStatsReq(
    (b) => b
      ..requestId = '@getMyStatsRequestId'
      ..vars.queryParams.limit = 10
      ..vars.queryParams.page = 1,
  );

  void handleFilterChange(GGetMyStatsReq newReq, StatisticsFilterData filter) {
    final client = ref.watch(appClientProvider);

    print(newReq.vars.queryParams.filters);
    setState(
      () {
        filterData = filter;
        getMyStatsReq = getMyStatsReq.rebuild((b) => b
          ..vars.queryParams.filters =
              newReq.vars.queryParams.filters?.toBuilder());
        client.requestController.add(getMyStatsReq);
        key = GlobalKey();
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
            if (response?.loading == true) {
              return const SizedBox();
            }

            if (response?.hasErrors == true) {
              return FitnessError(response: response);
            }

            final data = response?.data;
            final stats = data?.getMyStats.items?.toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StatisticsFilter(
                  filter: filterData,
                  request: GGetMyStatsReq(
                    (b) => b
                      ..vars.queryParams =
                          getMyStatsReq.vars.queryParams.toBuilder(),
                  ),
                  onChanged: (getMyStatsReq, selectedFilter) =>
                      handleFilterChange(getMyStatsReq, selectedFilter),
                ),
                StatisticsBodyData(
                  data: stats,
                ),
                const SizedBox(height: 16),
                StatisticsChart(
                  data: stats,
                  filter: filterData,
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
                if (isLogedIn && stats != null && stats.isNotEmpty == true)
                  const StatisticsRecentlyWorkout()
                else
                  FitnessEmpty(
                    title: i18n.common_Oops,
                    message: i18n.common_EmptyData,
                  ),
                const SizedBox(height: 16),
              ],
            );
          }),
    );
  }
}
