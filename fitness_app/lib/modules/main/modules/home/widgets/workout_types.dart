import 'package:fitness_app/modules/main/modules/home/widgets/workout_type_tile.dart';
import 'package:flutter/material.dart';

class WorkoutTypes extends StatefulWidget {
  const WorkoutTypes({super.key});

  @override
  State<WorkoutTypes> createState() => _WorkoutTypesState();
}

class _WorkoutTypesState extends State<WorkoutTypes> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const WorkoutTypeTile(
          typeName: 'Yoga',
          icon: Icons.sports_gymnastics,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 12),
    );
  }
}
