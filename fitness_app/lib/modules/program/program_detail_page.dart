import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/enums/workout_level.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/program/widgets/exercise_tile.dart';
import 'package:flutter/material.dart';

import '../../global/graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../global/widgets/program_info_tile.dart';

class ProgramDetailPage extends StatefulWidget {
  const ProgramDetailPage({
    super.key,
    required this.program,
  });

  final GGetProgramsData_getPrograms_items program;

  @override
  State<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

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
                      Text(
                        widget.program.name ?? '_',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProgramInfoTile(
                        label: '${widget.program.calo} Calories',
                        icon: Icons.local_fire_department_rounded,
                      ),
                      ProgramInfoTile(
                        label: '${widget.program.duration} Mins',
                        icon: Icons.timelapse,
                      ),
                      ProgramInfoTile(
                        label: WorkoutLevel.label(
                          widget.program.level ?? 0,
                          i18n,
                        ),
                        icon: Icons.fitness_center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
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
                ShadowWrapper(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.program.description ?? '_',
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
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (_, __) => const ExerciseTile(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
