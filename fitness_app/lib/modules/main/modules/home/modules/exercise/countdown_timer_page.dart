import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_stats.req.gql.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/utils/dialogs.dart';
import 'package:fitness_app/global/utils/exercise_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../global/gen/i18n.dart';
import '../../../../../../global/graphql/client.dart';
import '../../../../../../global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import '../../../../../../global/graphql/mutation/__generated__/mutation_upsert_user_exercise.req.gql.dart';
import '../../../../../../global/providers/current_stats_id.provider.dart';
import '../../../../../../global/providers/me_provider.dart';
import '../../../../../../global/themes/app_colors.dart';

class CountdownTimerPage extends ConsumerStatefulWidget {
  const CountdownTimerPage({
    super.key,
    this.initialDuration = const Duration(seconds: 3),
    this.isBreak = false,
    required this.exercises,
    this.index,
    this.program,
  });

  final Duration initialDuration;
  final bool isBreak;
  final int? index;
  final List<GExercise> exercises;
  final GProgram? program;

  @override
  ConsumerState<CountdownTimerPage> createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends ConsumerState<CountdownTimerPage> {
  late Duration countdownDuration = widget.initialDuration;
  late int seconds = widget.initialDuration.inSeconds;
  Timer? countdownTimer;

  void goToPlayVideo() {
    if (widget.isBreak) {
      context.popRoute();
    } else {
      context.replaceRoute(
        PlayExerciseRoute(
          exercises: widget.exercises,
          program: widget.program!,
        ),
      );
    }
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds = countdownDuration.inSeconds - 1;
        if (seconds < 0) {
          timer.cancel();
          goToPlayVideo();
        } else {
          countdownDuration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await initData();
    });
    startTimer();
    super.initState();
  }

  Future initData() async {
    if (widget.isBreak) {
      upsertStats();
      upsertUserExercise();
    }
  }

  void upsertStats() async {
    final user = ref.read(meProvider)?.user;

    final client = ref.watch(appClientProvider);
    final statsId = ref.watch(currentStatsId);
    final exercises = widget.index == 0
        ? [widget.exercises.first]
        : widget.exercises.getRange(0, widget.index ?? 0).toList();

    final calo = ExerciseHelper.getTotalCalo(exercises);
    final duration = ExerciseHelper.getTotalDuration(exercises);

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
      if (mounted) {
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

    var req = GUpsertUserExerciseReq((b) => b
      ..vars.input.exerciseId = widget.exercises[widget.index!].id
      ..vars.input.userId = user!.id);

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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: widget.isBreak
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                widget.isBreak
                    ? '${i18n.countdown_BreakTime},'
                    : i18n.countdown_ReadyToGo,
                style: TextStyle(
                  fontSize: isPortrait ? 35 : 30,
                  color: AppColors.primaryBold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.isBreak) ...[
                const SizedBox(height: 8),
                Text(
                  i18n.countdown_WalkAround,
                  style: TextStyle(
                    fontSize: isPortrait ? 25 : 20,
                    color: AppColors.primaryBold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Spacer(),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.square(
                      dimension: isPortrait ? 200 : 110,
                      child: CircularProgressIndicator(
                        value: ((widget.initialDuration.inSeconds - seconds) /
                                widget.initialDuration.inSeconds)
                            .toDouble(),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBold,
                        ),
                        backgroundColor: AppColors.primarySoft,
                        strokeWidth: 6,
                      ),
                    ),
                    Text(
                      countdownDuration.inSeconds.toString(),
                      style: TextStyle(
                        fontSize: isPortrait ? 100 : 50,
                        color: AppColors.primaryBold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isBreak) ...[
                SizedBox(height: isPortrait ? 48 : 22),
                Center(
                  child: Text(
                    i18n.countdown_YouHaveFinishCountEx(
                      '${widget.index ?? 0 + 1} / ${widget.exercises.length}',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryBold,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    i18n.countdown_DoNotForgetToDrinkWater,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryBold,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            countdownTimer?.cancel();
            goToPlayVideo();
          },
          child:
              Text(widget.isBreak ? i18n.button_Next : i18n.countdown_StartNow),
        ),
      ),
    );
  }
}
