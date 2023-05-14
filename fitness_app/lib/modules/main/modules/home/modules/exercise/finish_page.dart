import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_program.req.gql.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/utils/duration_time.dart';
import 'package:fitness_app/global/utils/exercise_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../global/gen/assets.gen.dart';
import '../../../../../../global/graphql/client.dart';
import '../../../../../../global/graphql/mutation/__generated__/mutation_upsert_stats.req.gql.dart';
import '../../../../../../global/providers/current_stats_id.provider.dart';
import '../../../../../../global/themes/app_colors.dart';
import '../../../../../../global/utils/dialogs.dart';

class FinishPage extends ConsumerStatefulWidget {
  const FinishPage({
    super.key,
    required this.exercises,
    required this.program,
  });
  final List<GExercise> exercises;
  final GProgram program;

  @override
  ConsumerState<FinishPage> createState() => _FinishPage();
}

class _FinishPage extends ConsumerState<FinishPage> {
  late final calo = ExerciseHelper.getTotalCalo(widget.exercises);
  late final duration = ExerciseHelper.getTotalDuration(widget.exercises);
  late final durationString =
      DurationTime.totalDurationFormat(Duration(seconds: duration.toInt()));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initData();
    });
    super.initState();
  }

  Future initData() async {}

  void upsertStats() async {
    final client = ref.watch(appClientProvider);
    final statsId = ref.watch(currentStatsId);
    final user = ref.watch(meProvider)?.user;

    var req = GUpsertStatsReq(
      (b) => b
        ..vars.input.id = statsId
        ..vars.input.caloCount = calo
        ..vars.input.durationCount = duration
        ..vars.input.programCount = 1
        ..vars.input.userId = user!.id,
    );

    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (context.mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    } else {
      ref
          .read(currentStatsId.notifier)
          .update((state) => response.data?.upsertStats.id);
    }
  }

  void upsertUserExercise() async {
    final user = ref.read(meProvider)?.user;
    final client = ref.watch(appClientProvider);

    var req = GUpsertUserProgramReq(
      (b) => b
        ..vars.input.programId = widget.program.id
        ..vars.input.userId = user!.id,
    );

    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 32),
            Assets.images.finish.image(
              height: 400,
            ),
            Text(
              i18n.finish_Hooray,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                StatisticItem(
                  title: widget.exercises.length.toString(),
                  subtitle: i18n.exercises_Exercises,
                  icon: const Icon(
                    Icons.format_list_numbered_outlined,
                    size: 30,
                    color: AppColors.success,
                  ),
                  color: AppColors.success,
                ),
                StatisticItem(
                  title: calo.toString(),
                  subtitle: i18n.common_Calories,
                  icon: const Icon(
                    Icons.local_fire_department,
                    size: 30,
                    color: AppColors.error,
                  ),
                  color: AppColors.error,
                ),
                StatisticItem(
                  title: durationString,
                  subtitle: i18n.common_Duration,
                  icon: const Icon(
                    Icons.timelapse,
                    size: 30,
                    color: AppColors.warning,
                  ),
                  color: AppColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            ref.read(currentStatsId.notifier).update((state) => null);
            AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
          },
          child: Text(i18n.finish_GoBackToHome),
        ),
      ),
    );
  }

  Widget StatisticItem({
    required Icon icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: icon,
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitle),
        ],
      ),
    );
  }
}
