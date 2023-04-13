import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/user_statistic_item.dart';

class StatisticsBodyData extends StatelessWidget {
  const StatisticsBodyData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        UserStatisticItem(
            title: '809',
            subtitle: 'Calories',
            icon: Icon(
              Icons.local_fire_department,
              size: 30,
              color: AppColors.error,
            )),
        UserStatisticItem(
            title: '600',
            subtitle: 'Minutes',
            icon: Icon(
              Icons.timelapse,
              size: 30,
              color: AppColors.warning,
            )),
        UserStatisticItem(
            title: '5',
            subtitle: 'Programs',
            icon: Icon(
              Icons.feed_rounded,
              size: 30,
              color: AppColors.success,
            )),
      ],
    );
  }
}
