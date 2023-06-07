import 'package:built_collection/src/list.dart';
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
import 'package:jiffy/jiffy.dart';

import '../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../global/graphql/client.dart';
import 'widgets/not_log_in_statistics.dart';
import 'widgets/statistics_chart.dart';
import 'widgets/statistics_overview.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  var filterData = StatisticsFilterData(
    rangeType: FilterRangeType.weekly,
    month: Jiffy().month,
    year: Jiffy().year,
  );
  var key = GlobalKey();
  var scaffoldKey = GlobalKey();

  late var getMyStatsReq = GGetMyStatsReq(
    (b) => b
      ..requestId = '@getMyStatsRequestId'
      ..vars.queryParams.limit = 200
      ..vars.queryParams.page = 1
      ..vars.queryParams.filters = ListBuilder(
        [
          GFilterDto(
            (b) => b
              ..data = filterData.rangeType!.startDate().toString()
              ..field = 'UserStatistics.updatedAt'
              ..operator = GFILTER_OPERATOR.gt,
          ),
          GFilterDto(
            (b) => b
              ..data = filterData.rangeType!.endDate().toString()
              ..field = 'UserStatistics.updatedAt'
              ..operator = GFILTER_OPERATOR.lt,
          ),
        ],
      ),
  );

  void handleFilterChange(GGetMyStatsReq newReq, StatisticsFilterData filter) {
    final client = ref.watch(appClientProvider);

    setState(() {
      key = GlobalKey();
      filterData = filter;
      getMyStatsReq = getMyStatsReq.rebuild((b) => b
        ..vars.queryParams.filters =
            newReq.vars.queryParams.filters?.toBuilder());
      client.requestController.add(getMyStatsReq);
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);
    final client = ref.watch(appClientProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: !isLogedIn
          ? const NotLoginStatistics()
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  scaffoldKey = GlobalKey();
                });
              },
              child: Operation(
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
                  final stats = data!.getMyStats.items!.toList();

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      StatisticsFilter(
                        filter: filterData,
                        request: getMyStatsReq,
                        onChanged: (getMyStatsReq, selectedFilter) =>
                            handleFilterChange(getMyStatsReq, selectedFilter),
                      ),
                      StatisticsOverview(
                        data: stats,
                      ),
                      const SizedBox(height: 16),
                      StatisticsChart(
                        key: key,
                        data: stats,
                        filter: filterData,
                      ),
                      const SizedBox(height: 32),
                      if (stats.isNotEmpty == true) ...[
                        Text(
                          i18n.statistics_RecentWorkout,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const StatisticsRecentlyWorkout(),
                        const SizedBox(height: 16),
                      ]
                    ],
                  );
                },
              ),
            ),
    );
  }
}
