import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../global/enums/workout_body_part.dart';
import '../../../../../../../../global/enums/workout_level.dart';
import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import '../../../../../../../../global/themes/app_colors.dart';
import '../../../../../../../../global/utils/duration_time copy.dart';
import 'program_info_tile.dart';

class ProgramOverview extends StatelessWidget {
  const ProgramOverview({
    super.key,
    required this.totalDuration,
    required this.totalCalo,
    required this.program,
  });

  final GProgram program;
  final double totalDuration;
  final double totalCalo;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final level = WorkoutLevel.getLevel(program.level ?? 1);
    final bodyPart = WorkoutBodyPart.getBodyPart(program.bodyPart ?? 1);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ProgramInfoTile(
                icon: Icons.macro_off,
                label: level.label(i18n),
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Icons.macro_off,
                label: DurationTime.totalDurationFormat(
                    Duration(seconds: totalDuration.toInt())),
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Icons.macro_off,
                label: totalCalo.toString(),
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Icons.macro_off,
                label: bodyPart.label(i18n),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShimmerProgramOverview extends StatelessWidget {
  const ShimmerProgramOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Row(
        children: [
          ...List.generate(4, (_) {
            return Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: AppColors.grey6),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.neutral20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 70,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.neutral20,
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
