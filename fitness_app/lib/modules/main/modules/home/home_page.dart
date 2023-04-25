import 'package:fitness_app/global/widgets/label.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/home_header.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/user_statistic.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/workout_programs.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/workout_types.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              UserStatistic(),
              Label('Your Plan'),
              SizedBox(
                height: 170,
                child: WorkoutPrograms(),
              ),
              Label('Select Plan'),
              SizedBox(
                height: 100,
                child: WorkoutTypes(),
              ),
              Label('Trending Now'),
              SizedBox(
                height: 170,
                child: WorkoutPrograms(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
