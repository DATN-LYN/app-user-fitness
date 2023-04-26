import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/workout_program_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/graphql/client.dart';
import '../../../../../global/widgets/fitness_empty.dart';

class WorkoutPrograms extends ConsumerStatefulWidget {
  const WorkoutPrograms({super.key});

  @override
  ConsumerState<WorkoutPrograms> createState() => _WorkoutProgramsState();
}

class _WorkoutProgramsState extends ConsumerState<WorkoutPrograms> {
  var getProgramsReq = GGetProgramsReq(
    (b) => b
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1
      ..vars.queryParams.orderBy = 'Program.createdAt:DESC',
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
          print('LOADING....');
          // return const ShimmerInbox();
        }

        if (response?.hasErrors == true || response?.data == null) {
          // return FitnessError(response: response);
          print(response?.linkException.toString());
          return const SizedBox();
        }

        final data = response!.data!.getPrograms;
        final hasMoreData = data.meta!.currentPage!.toDouble() <
            data.meta!.totalPages!.toDouble();
        final programs = data.items;

        if (programs?.isEmpty == true) {
          return FitnessEmpty(
            title: 'Empty',
            message: 'Inbox is empty',
            textButton: 'Refresh',
            image: Assets.images.sadFace.image(height: 100),
            onPressed: refreshHandler,
          );
        }

        return ListView.separated(
          itemCount: programs!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = programs[index];
            return WorkoutProgramTile(
              program: item,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 12);
          },
        );
      },
    );
  }
}
