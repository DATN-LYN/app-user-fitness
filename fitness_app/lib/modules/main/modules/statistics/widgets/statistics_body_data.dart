import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/stats/user_statistic_item.dart';

class StatisticsBodyData extends ConsumerWidget {
  const StatisticsBodyData({
    required this.duration,
    required this.programs,
    required this.exercises,
    super.key,
  });

  final double duration;
  final double programs;
  final double exercises;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);

    return Row(
      children: [
        UserStatisticItem(
          title: isLogedIn ? duration.toString() : '0',
          subtitle: i18n.common_Minutes,
          icon: const Icon(
            Icons.timelapse,
            size: 30,
            color: AppColors.warning,
          ),
          backgroundColor: AppColors.warningSoft,
        ),
        UserStatisticItem(
          title: isLogedIn ? programs.toString() : '0',
          subtitle: i18n.programs_Programs,
          icon: const Icon(
            Icons.feed_rounded,
            size: 30,
            color: AppColors.success,
          ),
          backgroundColor: AppColors.successSoft,
        ),
        UserStatisticItem(
          title: isLogedIn ? exercises.toString() : '0',
          subtitle: i18n.exercises_Exercises,
          icon: const Icon(
            Icons.fitness_center,
            size: 30,
            color: AppColors.alert,
          ),
          backgroundColor: AppColors.alertSoft,
        ),
      ],
    );
  }
}
