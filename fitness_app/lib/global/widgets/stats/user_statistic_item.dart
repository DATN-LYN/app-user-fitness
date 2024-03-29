import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class UserStatisticItem extends StatelessWidget {
  const UserStatisticItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
  });

  final Icon icon;
  final String title;
  final String subtitle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.grey6.withOpacity(0.5),
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
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
