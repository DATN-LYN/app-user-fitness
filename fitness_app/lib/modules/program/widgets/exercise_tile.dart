import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:flutter/material.dart';

import '../../../global/graphql/query/__generated__/query_get_excercises.data.gql.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final GGetExercisesData_getExercises_items exercise;

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
              imageUrl: widget.exercise.imgUrl ?? '_',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.exercise.name ?? '_',
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
                    Text(' ${widget.exercise.calo} calories'),
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
                    Text('${widget.exercise.duration} mins'),
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
