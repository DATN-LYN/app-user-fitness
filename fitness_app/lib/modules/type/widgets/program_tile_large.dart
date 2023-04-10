import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/program_info_tile.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';

class ProgramTileLarge extends StatefulWidget {
  const ProgramTileLarge({super.key});

  @override
  State<ProgramTileLarge> createState() => _ProgramTileLargeState();
}

class _ProgramTileLargeState extends State<ProgramTileLarge> {
  final textStyle = const TextStyle(
    color: AppColors.grey2,
  );
  @override
  Widget build(BuildContext context) {
    return ShadowWrapper(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => context.pushRoute(const ProgramDetailRoute()),
        child: Column(
          children: [
            const ShimmerImage(
              imageUrl:
                  'https://duhocthanhcong.vn/wp-content/uploads/school-photos/IMG%20Academy/IMG-Academy-Album1.jpg',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upper Body',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ProgramInfoTile(
                    icon: Icons.local_fire_department_rounded,
                    label: '40 Calories',
                    textStyle: textStyle,
                  ),
                  const SizedBox(height: 8),
                  ProgramInfoTile(
                    icon: Icons.timelapse,
                    label: '73 Min',
                    textStyle: textStyle,
                  ),
                  const SizedBox(height: 8),
                  ProgramInfoTile(
                    icon: Icons.fitness_center,
                    label: 'Any equipment',
                    textStyle: textStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
