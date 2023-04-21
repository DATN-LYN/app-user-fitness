import 'package:flutter/material.dart';

import '../../../../type/widgets/program_tile_large.dart';

class StatisticsRecentlyWorkout extends StatelessWidget {
  const StatisticsRecentlyWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const ProgramTileLarge();
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
