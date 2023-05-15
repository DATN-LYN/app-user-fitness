import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/client.dart';
import '../../../../../global/widgets/fitness_empty.dart';
import '../../../../../global/widgets/fitness_error.dart';
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
  var getProgramsReq = GGetProgramsReq(
    (b) => b
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1
      ..vars.queryParams.orderBy = 'Program.createdAt:DESC',
  );

  void refreshHanlder() {
    setState(() {
      getProgramsReq = getProgramsReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(appClientProvider);
    final i18n = I18n.of(context)!;

    return InfinityList(
      client: client,
      request: getProgramsReq,
      loadMoreRequest: (response) {
        final data = response?.data?.getPrograms;
        if (data != null &&
            data.meta!.currentPage!.toDouble() <
                data.meta!.totalPages!.toDouble()) {
          getProgramsReq = getProgramsReq.rebuild(
            (b) => b
              ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
              ..updateResult = (previous, result) =>
                  previous?.rebuild(
                    (b) => b.getPrograms
                      ..meta = (result?.getPrograms.meta ??
                              previous.getPrograms.meta)!
                          .toBuilder()
                      ..items.addAll(
                        result?.getPrograms.items ?? [],
                      ),
                  ) ??
                  result,
          );
          return getProgramsReq;
        }
        return null;
      },
      refreshRequest: () {
        getProgramsReq = getProgramsReq.rebuild(
          (b) => b
            ..vars.queryParams.page = 1
            ..updateResult = ((previous, result) => result),
        );
        return getProgramsReq;
      },
      builder: (context, response, error) {
        if ((response?.hasErrors == true ||
                response?.data?.getPrograms.meta?.itemCount == 0) &&
            getProgramsReq.vars.queryParams.page != 1) {
          getProgramsReq = getProgramsReq.rebuild(
            (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
          );
        }

        if (response?.hasErrors == true) {
          return FitnessError(response: response);
        }

        if (response?.loading ?? false || response?.data == null) {
          const ShimmerProgramLargeList();
        }
        final data = response!.data?.getPrograms;

        final programs = data?.items;

        if (programs?.isEmpty == true) {
          return FitnessEmpty(
            title: i18n.programs_ProgramNotFound,
            onPressed: refreshHanlder,
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: programs!.length > 10 ? 10 : programs.length,
          itemBuilder: (context, index) {
            final item = programs[index];
            return ProgramItemLarge(program: item);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
        );
      },
    );
  }
}
