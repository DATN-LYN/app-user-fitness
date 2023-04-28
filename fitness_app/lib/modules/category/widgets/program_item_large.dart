import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/enums/workout_level.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/program_info_tile.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../global/gen/i18n.dart';
import '../../../global/graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../../global/routers/app_router.dart';

class ProgramItemLarge extends StatefulWidget {
  const ProgramItemLarge({
    super.key,
    required this.program,
  });

  final GGetProgramsData_getPrograms_items program;

  @override
  State<ProgramItemLarge> createState() => _ProgramItemLargeState();
}

class _ProgramItemLargeState extends State<ProgramItemLarge> {
  final textStyle = const TextStyle(
    color: AppColors.grey2,
  );

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    return ShadowWrapper(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => context.pushRoute(
          ProgramDetailRoute(program: widget.program),
        ),
        child: Column(
          children: [
            ShimmerImage(
              imageUrl: widget.program.imgUrl ?? '_',
              height: 150,
              width: double.infinity,
              fit: BoxFit.fill,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.program.bodyPart ?? '_',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ProgramInfoTile(
                    icon: Icons.local_fire_department_rounded,
                    label: '${widget.program.calo} Calories',
                    textStyle: textStyle,
                  ),
                  const SizedBox(height: 8),
                  ProgramInfoTile(
                    icon: Icons.timelapse,
                    label: '${widget.program.duration} Mins',
                    textStyle: textStyle,
                  ),
                  const SizedBox(height: 8),
                  ProgramInfoTile(
                    icon: Icons.fitness_center,
                    label: WorkoutLevel.label(widget.program.level ?? 0, i18n),
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
