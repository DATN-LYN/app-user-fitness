import 'package:fitness_app/modules/main/modules/home/widgets/workout_program_tile.dart';
import 'package:flutter/material.dart';

class WorkoutPrograms extends StatefulWidget {
  const WorkoutPrograms({super.key});

  @override
  State<WorkoutPrograms> createState() => _WorkoutProgramsState();
}

class _WorkoutProgramsState extends State<WorkoutPrograms> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const WorkoutProgramTile(
          title: 'Upper Body',
          duration: '50 mins',
          imageUrl:
              'https://duhocthanhcong.vn/wp-content/uploads/school-photos/IMG%20Academy/IMG-Academy-Album1.jpg',
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 12);
      },
    );
  }
}
