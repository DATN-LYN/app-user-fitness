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
          icon: Icons.woman,
          color: AppColors.background,
        ),
        UserStatisticTile(
          title: '809',
          subtitle: 'Calories',
          icon: Icons.woman,
          color: AppColors.primary,
        ),
        UserStatisticTile(
          title: '809',
          subtitle: 'Calories',
          icon: Icons.woman,
          color: AppColors.grey4,
        ),
      ],
    );
  }

  Widget UserStatisticTile({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 30),
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
