import 'package:fitness_app/global/widgets/user_statistic_item.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class UserStatistic extends StatefulWidget {
  const UserStatistic({super.key});

  @override
  State<UserStatistic> createState() => _UserStatisticState();
}

class _UserStatisticState extends State<UserStatistic> {
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
