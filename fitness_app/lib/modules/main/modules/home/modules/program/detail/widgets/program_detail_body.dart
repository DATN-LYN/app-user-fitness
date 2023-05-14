import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/auth_helper.dart';
import 'package:fitness_app/global/utils/exercise_helper.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/detail/widgets/program_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../global/graphql/client.dart';
import '../../../../../../../../global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import '../../../../../../../../global/providers/me_provider.dart';
import '../../../../../../../../global/routers/app_router.dart';
import '../../../../../../../../global/utils/constants.dart';
import '../../../../../../../../global/widgets/fitness_empty.dart';
import '../../../../../../../../global/widgets/fitness_error.dart';
import '../../../../../../../../global/widgets/infinity_list.dart';
import '../../../../../../../../global/widgets/shadow_wrapper.dart';
import 'exercise_tile.dart';
import 'shimmer_exercise_list.dart';

class ProgramDetailBody extends ConsumerStatefulWidget {
  const ProgramDetailBody({
    super.key,
    this.program,
    this.loading,
  });

  final GProgram? program;
  final bool? loading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ProgramDetailBody> {
  double totalDuration = 0;
  double totalCalo = 0;
  bool? loading = false;
  var getExercisesReq = GGetExercisesReq();
  List<GExercise> exerciseList = [];

  @override
  void initState() {
    getExercisesReq = GGetExercisesReq(
      (b) => b
        ..requestId = '@getExercisesByProgramRequestId'
        ..vars.queryParams.limit = Constants.defaultLimit
        ..vars.queryParams.page = 1
        ..vars.queryParams.filters = ListBuilder(
          [
            GFilterDto(
              (b) => b
                ..data = widget.program?.id
                ..field = 'Exercise.programId'
                ..operator = GFILTER_OPERATOR.eq,
            ),
          ],
        ),
    );
    super.initState();
  }

  void initData() async {
    await initReq();
  }

  Future initReq() async {
    setState(() {});
  }

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
  void didUpdateWidget(covariant ProgramDetailBody oldWidget) {
    if (widget.loading != oldWidget.loading) {
      loading = widget.loading;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(appClientProvider);
    final i18n = I18n.of(context)!;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (loading == true)
              const ShimmerProgramOverview()
            else
              ProgramOverview(
                program: widget.program!,
                totalDuration: totalDuration,
                totalCalo: totalCalo,
              ),
            _programDescription(),
            Text(
              i18n.exercises_Exercises,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            InfinityList(
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
                // if ((response?.hasErrors == true ||
                //         response?.data?.getExercises.meta?.itemCount == 0) &&
                //     getExercisesReq.vars.queryParams.page != 1) {
                //   getExercisesReq = getExercisesReq.rebuild(
                //     (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
                //   );
                // }

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
                    title: i18n.common_EmptyData,
                    message: i18n.exercises_ExerciseNotFound,
                    textButton: i18n.button_TryAgain,
                    onPressed: refreshHandler,
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    exerciseList = exercises!.toList();
                    totalDuration =
                        ExerciseHelper.getTotalDuration(exerciseList.toList());
                    totalCalo =
                        ExerciseHelper.getTotalCalo(exerciseList.toList());
                  });
                });

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
            ),
          ],
        ),
        if (exerciseList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 40),
            child: FloatingActionButton(
              backgroundColor: AppColors.grey1,
              child: const Icon(
                Icons.play_arrow,
                color: AppColors.white,
              ),
              onPressed: () {
                final isLogedIn = ref.read(isSignedInProvider);
                if (isLogedIn) {
                  context.pushRoute(
                    CountdownTimerRoute(
                      exercises: exerciseList.toList(),
                      // program: widget.program,
                    ),
                  );
                } else {
                  AuthHelper.showLoginDialog(context);
                }
              },
            ),
          ),
      ],
    );
  }

  Widget shimmerDescription() {
    return ShimmerWrapper(
      child: Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.neutral20,
        ),
      ),
    );
  }

  Widget _programDescription() {
    final i18n = I18n.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Text(
          i18n.common_Description,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ShadowWrapper(
          padding: const EdgeInsets.all(16),
          child: loading == true
              ? shimmerDescription()
              : Text(
                  widget.program?.description ?? '',
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
