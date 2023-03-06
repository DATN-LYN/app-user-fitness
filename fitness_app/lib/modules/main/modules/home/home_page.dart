import 'package:fitness_app/global/widgets/label.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/home_header.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/user_statistic.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/workout_series.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/workout_type.dart';
import 'package:flutter/material.dart';

import '../../../../global/utils/client_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: const [
                  UserStatistic(
                    title: '809',
                    subtitle: 'Calories',
                    icon: Icons.woman,
                  ),
                  UserStatistic(
                    title: '809',
                    subtitle: 'Calories',
                    icon: Icons.woman,
                  ),
                  UserStatistic(
                    title: '809',
                    subtitle: 'Calories',
                    icon: Icons.woman,
                  ),
                ],
              ),
              const Label('Your Plan'),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const WorkoutSeries(
                      title: 'Upper Body',
                      duration: '50 mins',
                      imageUrl: 'jdajdi',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                ),
              ),
              const Label('Select Plan'),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const WorkoutType(
                      workoutType: 'Yoga',
                      icon: Icons.sports_gymnastics,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemCount: 10,
                ),
              ),
              const Label('Trending Now'),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const WorkoutSeries(
                      title: 'Chest and Triceps',
                      duration: '40 mins',
                      imageUrl: 'jajsaj',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
