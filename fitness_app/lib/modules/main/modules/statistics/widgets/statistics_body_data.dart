import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/query/__generated__/query_get_my_stats.data.gql.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/stats/user_statistic_item.dart';

class StatisticsBodyData extends ConsumerWidget {
  const StatisticsBodyData({
    required this.data,
    super.key,
  });

  final List<GGetMyStatsData_getMyStats_items>? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);
    final hasData = data != null && data?.isNotEmpty == true;
    final calo = hasData
        ? data!.map((e) => e.caloCount).reduce((a, b) => a! + b!).toString()
        : '0';
    final duration = hasData
        ? data!.map((e) => e.durationCount).reduce((a, b) => a! + b!).toString()
        : '0';

    return Column(
      children: [
        Row(
          children: [
            UserStatisticItem(
              title: duration,
              subtitle: i18n.common_Minutes,
              icon: const Icon(
                Icons.timelapse,
                size: 30,
                color: AppColors.warning,
              ),
              backgroundColor: AppColors.warningSoft,
            ),
            UserStatisticItem(
              title: hasData
                  ? data!
                      .map((e) => e.programCount)
                      .reduce((a, b) => a! + b!)
                      .toString()
                  : '0',
              subtitle: i18n.programs_Programs,
              icon: const Icon(
                Icons.feed_rounded,
                size: 30,
                color: AppColors.success,
              ),
              backgroundColor: AppColors.successSoft,
            ),
          ],
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
                    ? '$calo ${i18n.statistics_Calories}. '
                    : '0 ${i18n.statistics_Calories}. ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBold,
                ),
              ),
              if (double.parse(calo) > 0)
                TextSpan(
                  text: i18n.statistics_WhatAGreatValue,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
