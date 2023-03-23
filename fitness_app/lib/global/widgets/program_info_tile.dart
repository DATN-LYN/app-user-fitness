import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class ProgramInfoTile extends StatelessWidget {
  const ProgramInfoTile({
    super.key,
    required this.label,
    required this.icon,
    this.textStyle = const TextStyle(fontWeight: FontWeight.w700),
  });

  final String label;
  final IconData icon;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.grey1,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(label, style: textStyle),
      ],
    );
  }
}
