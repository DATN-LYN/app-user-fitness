import 'package:fitness_app/global/gen/i18n.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/user_statistic_item.dart';

class StatisticsBodyData extends StatelessWidget {
  const StatisticsBodyData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Row(
      children: [
        UserStatisticItem(
            title: '809',
            subtitle: i18n.common_Calories,
            icon: const Icon(
              Icons.local_fire_department,
              size: 30,
              color: AppColors.error,
            )),
        UserStatisticItem(
            title: '600',
            subtitle: i18n.common_Minutes,
            icon: const Icon(
              Icons.timelapse,
              size: 30,
              color: AppColors.warning,
            )),
        UserStatisticItem(
            title: '5',
            subtitle: i18n.programs_Programs,
            icon: const Icon(
              Icons.feed_rounded,
              size: 30,
              color: AppColors.success,
            )),
      ],
    );
  }
}
