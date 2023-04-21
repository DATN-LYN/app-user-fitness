import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({super.key});

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return ShadowWrapper(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: 120,
              height: 80,
              fit: BoxFit.cover,
              imageUrl:
                  'https://duhocthanhcong.vn/wp-content/uploads/school-photos/IMG%20Academy/IMG-Academy-Album1.jpg',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dumbell Fly',
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(
                      Icons.local_fire_department_sharp,
                      size: 18,
                      color: AppColors.grey5,
                    ),
                    SizedBox(width: 4),
                    Text('40 calories'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(
                      Icons.access_time_filled,
                      size: 18,
                      color: AppColors.grey5,
                    ),
                    SizedBox(width: 4),
                    Text('4 mins'),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
          )
        ],
      ),
    );
  }
}
