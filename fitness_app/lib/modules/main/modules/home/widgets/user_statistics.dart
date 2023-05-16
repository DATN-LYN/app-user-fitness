import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/global/utils/date_time_helper.dart';
import 'package:fitness_app/global/widgets/stats/user_statistic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/client.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/fitness_empty.dart';
import '../../../../../global/widgets/fitness_error.dart';
import '../../../../../global/widgets/shimmer_wrapper.dart';

class UserStatistic extends ConsumerWidget {
  const UserStatistic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);
    var req = GGetMyStatsReq(
      (b) => b
        ..vars.queryParams.limit = 10
        ..vars.queryParams.page = 1
        ..vars.queryParams.orderBy = 'UserStatistics.createdAt',
    );

    return Operation(
      client: client,
      operationRequest: req,
      builder: (context, response, error) {
        if (response?.loading == true) {
          return const ShimmerUserStatistics();
        }

        if (response?.hasErrors ?? false) {
          return FitnessError(
            response: response,
            showImage: false,
          );
        }
        final data = response!.data!;
        final stats = data.getMyStats.items;

        if (stats?.isEmpty == true) {
          return FitnessEmpty(
            title: i18n.common_EmptyData,
            message: i18n.common_PleasePullToTryAgain,
            showImage: false,
          );
        }

        final calo =
            stats?.map((e) => e.caloCount).reduce((a, b) => a! + b!)!.round();

        final duration =
            stats?.map((e) => e.durationCount).reduce((a, b) => a! + b!);

        final programs =
            stats?.map((e) => e.programCount).reduce((a, b) => a! + b!);

        return Row(
          children: [
            UserStatisticItem(
              title: calo.toString(),
              subtitle: i18n.common_Calories,
              icon: const Icon(
                Icons.local_fire_department,
                size: 30,
                color: AppColors.error,
              ),
              backgroundColor: AppColors.errorSoft,
            ),
            UserStatisticItem(
              title: DateTimeHelper.totalDurationFormat(
                Duration(
                  seconds: duration!.toInt(),
                ),
              ),
              subtitle: i18n.common_Duration,
              icon: const Icon(
                Icons.timelapse,
                size: 30,
                color: AppColors.information,
              ),
              backgroundColor: AppColors.informationSoft,
            ),
            UserStatisticItem(
              title: programs?.toInt().toString() ?? '_',
              subtitle: i18n.programs_Programs,
              icon: const Icon(
                Icons.feed_rounded,
                size: 30,
                color: AppColors.success,
              ),
              backgroundColor: AppColors.successSoft,
            ),
          ],
        );
      },
    );
  }
}

class ShimmerUserStatistics extends StatelessWidget {
  const ShimmerUserStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.neutral20,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerWrapper(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ShimmerWrapper(
                  child: Container(
                    height: 10,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ShimmerWrapper(
                  child: Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral20,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}

class UnLoginUserStatistics extends StatelessWidget {
  const UnLoginUserStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Row(
      children: [
        UserStatisticItem(
          title: '0',
          subtitle: i18n.common_Calories,
          icon: const Icon(
            Icons.local_fire_department,
            size: 30,
            color: AppColors.error,
          ),
          backgroundColor: AppColors.errorSoft,
        ),
        UserStatisticItem(
          title: '0',
          subtitle: i18n.common_Duration,
          icon: const Icon(
            Icons.timelapse,
            size: 30,
            color: AppColors.information,
          ),
          backgroundColor: AppColors.informationSoft,
        ),
        UserStatisticItem(
          title: '0',
          subtitle: i18n.programs_Programs,
          icon: const Icon(
            Icons.feed_rounded,
            size: 30,
            color: AppColors.success,
          ),
          backgroundColor: AppColors.successSoft,
        ),
      ],
    );
  }
}
