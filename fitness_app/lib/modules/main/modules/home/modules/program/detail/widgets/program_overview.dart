import 'package:fitness_app/global/extensions/body_part_extension.dart';
import 'package:fitness_app/global/extensions/workout_level_extension.dart';
import 'package:fitness_app/global/utils/date_time_helper.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import '../../../../../../../../global/themes/app_colors.dart';
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ProgramInfoTile(
                icon: Ionicons.stats_chart,
                label: program.level!.label(i18n),
                iconColor: AppColors.success,
                backgroundColor: AppColors.successSoft,
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Ionicons.time,
                label: DateTimeHelper.totalDurationFormat(
                  Duration(seconds: totalDuration.toInt()),
                ),
                iconColor: AppColors.alert,
                backgroundColor: AppColors.alertSoft,
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Ionicons.fitness,
                label: totalCalo.toString(),
                iconColor: AppColors.error,
                backgroundColor: AppColors.errorSoft,
              ),
            ),
            Expanded(
              child: ProgramInfoTile(
                icon: Ionicons.body,
                label: program.bodyPart!.label(i18n),
                iconColor: AppColors.information,
                backgroundColor: AppColors.informationSoft,
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
