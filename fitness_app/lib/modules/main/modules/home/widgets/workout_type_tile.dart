import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class WorkoutTypeTile extends StatefulWidget {
  const WorkoutTypeTile({
    super.key,
    required this.icon,
    required this.typeName,
  });

  final IconData icon;
  final String typeName;

  @override
  State<WorkoutTypeTile> createState() => _WorkoutTypeTileState();
}

class _WorkoutTypeTileState extends State<WorkoutTypeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const TypeDetailRoute()),
      child: Column(
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
            widget.typeName,
            style: const TextStyle(
              color: AppColors.grey2,
            ),
          )
        ],
      ),
    );
  }
}
