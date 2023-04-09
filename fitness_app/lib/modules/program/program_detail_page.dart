import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/program/widgets/exercise_tile.dart';
import 'package:flutter/material.dart';

import '../../global/widgets/program_info_tile.dart';

class ProgramDetailPage extends StatefulWidget {
  const ProgramDetailPage({super.key});

  @override
  State<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.grey1,
        child: const Icon(
          Icons.play_arrow,
          color: AppColors.white,
        ),
        onPressed: () {
          context.pushRoute(CountdownTimerRoute());
        },
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox.square(
                        dimension: 40,
                        child: IconButton(
                          onPressed: () {
                            context.popRoute();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                      const Text(
                        'Chest And Tricep',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      ProgramInfoTile(
                        label: '40 Cal',
                        icon: Icons.local_fire_department_rounded,
                      ),
                      ProgramInfoTile(
                        label: '73 Min',
                        icon: Icons.timelapse,
                      ),
                      ProgramInfoTile(
                        label: 'Any equipment',
                        icon: Icons.fitness_center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ShadowWrapper(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'dajsdhajkshdjashdjashdajshdajsdhajshdajsdhjashdajshdajhsdjahsdjashdjashdajdhajshdjasdhajsdhjkahdjkahdjakhdajkshdjaskhd',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Exercises',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (_, __) => const ExerciseTile(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
