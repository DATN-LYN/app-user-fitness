import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/client.dart';
import '../../../../../global/widgets/fitness_empty.dart';
import '../../../../../global/widgets/fitness_error.dart';
import 'program_item.dart';

class ProgramListMostViewed extends ConsumerStatefulWidget {
  const ProgramListMostViewed({super.key});

  @override
  ConsumerState<ProgramListMostViewed> createState() => _WorkoutProgramsState();
}

class _WorkoutProgramsState extends ConsumerState<ProgramListMostViewed> {
  var getProgramsReq = GGetProgramsReq(
    (b) => b
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1
      ..vars.queryParams.orderBy = 'Program.view:DESC',
  );

  void refreshHandler() {
    setState(
      () => getProgramsReq = getProgramsReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      ),
    );
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

        if (response?.loading == true) {
          return const ShimmerProgramList();
        }

        if (response?.hasErrors == true || response?.data == null) {
          return const FitnessError(
            // response: response,
            showImage: false,
          );
        }

        final data = response!.data!.getPrograms;
        final programs = data.items;

        if (programs?.isEmpty == true) {
          return FitnessEmpty(
            title: i18n.programs_ProgramNotFound,
            message: i18n.common_PleasePullToTryAgain,
            showImage: false,
          );
        }

        return ListView.separated(
          itemCount: programs!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = programs[index];
            return ProgramItem(
              program: item,
              showView: true,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        );
      },
    );
  }
}

class ShimmerProgramList extends StatelessWidget {
  const ShimmerProgramList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.neutral20,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWrapper(
                child: Container(
                  height: 100,
                  width: 180,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    color: AppColors.neutral20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShimmerWrapper(
                child: Container(
                  height: 10,
                  width: 60,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.neutral20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShimmerWrapper(
                child: Container(
                  height: 10,
                  width: 100,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.neutral20,
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 12),
    );
  }
}
