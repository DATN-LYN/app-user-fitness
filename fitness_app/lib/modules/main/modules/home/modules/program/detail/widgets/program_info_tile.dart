import 'package:flutter/material.dart';

import '../../../../../../../../global/themes/app_colors.dart';

class ProgramInfoTile extends StatelessWidget {
  const ProgramInfoTile({
    super.key,
    this.label,
    required this.icon,
    this.textStyle = const TextStyle(fontWeight: FontWeight.w700),
    this.iconColor = AppColors.grey1,
    this.backgroundColor = AppColors.grey6,
  });

  final String? label;
  final IconData icon;
  final TextStyle textStyle;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            label ?? '_',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
