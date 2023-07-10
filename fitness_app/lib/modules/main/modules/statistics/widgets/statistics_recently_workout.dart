import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/client.dart';
import '../../../../../global/graphql/query/__generated__/query_get_current_user.req.gql.dart';
import '../../../../../global/widgets/fitness_empty.dart';
import '../../../../../global/widgets/program/program_item_large.dart';
import '../../../../../global/widgets/program/shimmer_program_large_list.dart';

class StatisticsRecentlyWorkout extends ConsumerStatefulWidget {
  const StatisticsRecentlyWorkout({super.key});

  @override
  ConsumerState<StatisticsRecentlyWorkout> createState() =>
      _StatisticsRecentlyWorkoutState();
}

class _StatisticsRecentlyWorkoutState
    extends ConsumerState<StatisticsRecentlyWorkout> {
  bool loading = true;
  List<GProgram>? programs;
  var getCurrentUserReq = GGetCurrentUserReq();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserPrograms();
    });
    super.initState();
  }

  void refreshHandler() {
    setState(
      () => getCurrentUserReq = getCurrentUserReq.rebuild(
        (b) => b..updateResult = ((previous, result) => result),
      ),
    );
  }

  void getUserPrograms() async {
    final client = ref.watch(appClientProvider);

    final res = await client.request(getCurrentUserReq).first;
    if (mounted) {
      setState(() => loading = false);
    }

    if (res.hasErrors) {
      if (mounted) {
        // DialogUtils.showError(context: context, response: res);
      }
    } else {
      final result = res.data?.getCurrentUser.userPrograms;
      if (mounted) {
        setState(
          () => programs =
              result?.map((e) => e.program as GProgram).toSet().toList(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    if (loading) {
      return const ShimmerProgramLargeList();
    }

    if (programs?.isEmpty == true) {
      return FitnessEmpty(
        title: i18n.programs_ProgramNotFound,
        onPressed: refreshHandler,
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: (programs?.length ?? 0) > 10 ? 10 : programs!.length,
      itemBuilder: (context, index) {
        final item = programs![index];
        return ProgramItemLarge(program: item);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
