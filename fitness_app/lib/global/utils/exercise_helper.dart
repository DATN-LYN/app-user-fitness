import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/client.dart';
import '../graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import '../graphql/mutation/__generated__/mutation_upsert_stats.req.gql.dart';
import '../graphql/mutation/__generated__/mutation_upsert_user_exercise.req.gql.dart';
import '../graphql/mutation/__generated__/mutation_upsert_user_program.req.gql.dart';
import '../providers/current_stats_id.provider.dart';
import '../providers/me_provider.dart';
import 'dialogs.dart';

class ExerciseHelper {
  ExerciseHelper._();

  static double getTotalCalo(List<GExercise> exercises) {
    return exercises.map((e) => e.calo).reduce((a, b) => a! + b!) ?? 0;
  }

  static double getTotalDuration(List<GExercise> exercises) {
    return exercises.map((e) => e.duration).reduce((a, b) => a! + b!) ?? 0;
  }

  static void upsertUserProgram(
    BuildContext context,
    WidgetRef ref, {
    required String programId,
  }) async {
    final user = ref.read(meProvider);
    final client = ref.watch(appClientProvider);

    var req = GUpsertUserProgramReq(
      (b) => b
        ..vars.input.programId = programId
        ..vars.input.userId = user!.id,
    );

    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (context.mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    }
  }

  static void upsertUserExercise(
    BuildContext context,
    WidgetRef ref, {
    required String exerciseId,
  }) async {
    final user = ref.read(meProvider);
    final client = ref.watch(appClientProvider);

    var req = GUpsertUserExerciseReq((b) => b
      ..vars.input.exerciseId = exerciseId
      ..vars.input.userId = user!.id);

    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (context.mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    }
  }

  static void upsertStats(
    BuildContext context,
    WidgetRef ref, {
    required double calo,
    required double duration,
  }) async {
    final statsId = ref.watch(currentStatsId);
    final user = ref.read(meProvider);
    final client = ref.watch(appClientProvider);

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
}
