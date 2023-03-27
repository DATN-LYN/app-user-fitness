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
      children: [
        UserStatisticTile(
          title: '809',
          subtitle: 'Calories',
          icon: const Icon(
            Icons.local_fire_department,
            size: 30,
            color: AppColors.error,
          ),
        ),
        UserStatisticTile(
          title: '600',
          subtitle: 'Minutes',
          icon: const Icon(
            Icons.timelapse,
            size: 30,
            color: AppColors.warning,
          ),
        ),
        UserStatisticTile(
          title: '5',
          subtitle: 'Programs',
          icon: const Icon(
            Icons.feed_rounded,
            size: 30,
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget UserStatisticTile({
    required Icon icon,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.grey6.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 25),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}
