import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/graphql/client.dart';
import '../../../global/graphql/query/__generated__/query_get_excercises.req.gql.dart';
import '../../../global/utils/constants.dart';
import '../../../global/widgets/fitness_empty.dart';
import '../../../global/widgets/fitness_error.dart';
import '../../../global/widgets/infinity_list.dart';
import 'exercise_tile.dart';

class ExerciseList extends ConsumerStatefulWidget {
  const ExerciseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ExerciseList> {
  var getExercisesReq = GGetExercisesReq(
    (b) => b
      ..requestId = '@getExercisesByProgramRequestIs'
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1,
  );

  void refreshHandler() {
    setState(() {
      getExercisesReq = getExercisesReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(appClientProvider);

    return InfinityList(
      client: client,
      request: getExercisesReq,
      loadMoreRequest: (response) {
        final data = response?.data?.getExercises;
        if (data != null &&
            data.meta!.currentPage!.toDouble() <
                data.meta!.totalPages!.toDouble()) {
          getExercisesReq = getExercisesReq.rebuild(
            (b) => b
              ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
              ..updateResult = (previous, result) =>
                  previous?.rebuild(
                    (b) => b.getExercises
                      ..meta = (result?.getExercises.meta ??
                              previous.getExercises.meta)!
                          .toBuilder()
                      ..items.addAll(
                        result?.getExercises.items ?? [],
                      ),
                  ) ??
                  result,
          );
          return getExercisesReq;
        }
        return null;
      },
      refreshRequest: () {
        getExercisesReq = getExercisesReq.rebuild(
          (b) => b
            ..vars.queryParams.page = 1
            ..updateResult = ((previous, result) => result),
        );
        return getExercisesReq;
      },
      builder: (context, response, error) {
        if ((response?.hasErrors == true ||
                response?.data?.getExercises.meta?.itemCount == 0) &&
            getExercisesReq.vars.queryParams.page != 1) {
          getExercisesReq = getExercisesReq.rebuild(
            (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
          );
        }

        if (response?.loading == true) {
          return const ShimmerExerciseList();
        }

        if (response?.hasErrors == true || response?.data == null) {
          return FitnessError(
            response: response,
            showImage: true,
          );
        }

        final data = response!.data!.getExercises;
        final hasMoreData = data.meta!.currentPage!.toDouble() <
            data.meta!.totalPages!.toDouble();
        final exercises = data.items;

        if (exercises?.isEmpty == true) {
          return FitnessEmpty(
            showImage: true,
            title: 'No Data',
            message: 'Please pull to refresh to try again',
            textButton: 'Try Again',
            onPressed: refreshHandler,
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercises!.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            final item = exercises[index];

            return ExerciseTile(exercise: item);
          },
        );
      },
    );
  }
}

class ShimmerExerciseList extends StatelessWidget {
  const ShimmerExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.neutral20,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 15,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 15,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      ),
    );
  }
}
