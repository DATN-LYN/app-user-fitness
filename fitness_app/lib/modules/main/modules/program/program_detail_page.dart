import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/program/widgets/exercise_tile.dart';
import 'package:flutter/material.dart';

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
        onPressed: () {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.grey1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
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
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'Chest And Tricep',
                        style: TextStyle(
                          color: AppColors.white,
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
                        icon: Icons.fire_extinguisher,
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
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ExerciseTile();
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ProgramInfoTile extends StatelessWidget {
  const ProgramInfoTile({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
