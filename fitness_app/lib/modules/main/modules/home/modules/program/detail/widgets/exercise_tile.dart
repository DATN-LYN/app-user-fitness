import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/date_time_helper.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final GExercise exercise;

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
              imageUrl: exercise.imgUrl ?? '_',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name ?? '_',
                  style: const TextStyle(
                    color: AppColors.grey1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_sharp,
                      size: 18,
                      color: AppColors.grey5,
                    ),
                    const SizedBox(width: 4),
                    Text(' ${exercise.calo ?? 0} calories'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      size: 18,
                      color: AppColors.grey5,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateTimeHelper.totalDurationFormat(
                        Duration(seconds: exercise.duration!.toInt()),
                      ),
                    ),
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
