import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class ProgramInfoTile extends StatelessWidget {
  const ProgramInfoTile({
    super.key,
    this.label,
    required this.icon,
    this.textStyle = const TextStyle(fontWeight: FontWeight.w700),
  });

  final String? label;
  final IconData icon;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.grey2,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(label ?? '_', style: textStyle),
      ],
    );
  }
}
