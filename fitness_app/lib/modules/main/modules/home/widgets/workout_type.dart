import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class WorkoutType extends StatefulWidget {
  const WorkoutType({
    super.key,
    required this.workoutType,
    required this.icon,
  });

  final String workoutType;
  final IconData icon;

  @override
  State<WorkoutType> createState() => _WorkoutTypeState();
}

class _WorkoutTypeState extends State<WorkoutType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: AppColors.grey5,
            ),
          ),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            splashRadius: 30,
            onPressed: () {},
            icon: Icon(
              widget.icon,
              color: AppColors.grey2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.workoutType,
          style: const TextStyle(
            color: AppColors.grey2,
          ),
        )
      ],
    );
  }
}
