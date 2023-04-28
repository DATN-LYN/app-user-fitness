import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/enums/workout_level.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_excercises.req.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_program.req.gql.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/utils/dialogs.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/program/widgets/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/graphql/client.dart';
import '../../global/graphql/query/__generated__/query_get_program.data.gql.dart';
import '../../global/graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../global/widgets/fitness_empty.dart';
import '../../global/widgets/fitness_error.dart';
import '../../global/widgets/program_info_tile.dart';

class ProgramDetailPage extends ConsumerStatefulWidget {
  const ProgramDetailPage({
    super.key,
    required this.program,
  });

  final GGetProgramsData_getPrograms_items program;

  @override
  ConsumerState<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends ConsumerState<ProgramDetailPage> {
  GGetProgramData_getProgram? program;
  bool loading = false;
  var getExercisesReq = GGetExercisesReq(
    (b) => b
      ..requestId = '@getExercisesByProgramRequestIs'
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1,
  );

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Future.wait([
      getProgram(),
    ]);
  }

  Future getProgram() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    final client = ref.watch(appClientProvider);

    final getProgramReq = GGetProgramReq(
      (b) => b
        ..requestId = '@getProgramRequestId'
        ..vars.programId = widget.program.id,
    );

    final res = await client.request(getProgramReq).first;
    setState(() => loading = false);

    if (res.hasErrors) {
      if (mounted) {
        DialogUtils.showError(context: context, response: res);
      }
    } else {
      setState(() {
        program = res.data!.getProgram;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);

    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.grey1,
          child: const Icon(
            Icons.play_arrow,
            color: AppColors.white,
          ),
          onPressed: () {
            context.pushRoute(CountdownTimerRoute());
          },
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox.square(
                          dimension: 40,
                          child: IconButton(
                            onPressed: () {
                              context.popRoute();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                        Text(
                          program?.name ?? '_',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProgramInfoTile(
                          label: '${program?.calo} Calories',
                          icon: Icons.local_fire_department_rounded,
                        ),
                        ProgramInfoTile(
                          label: '${program?.duration} Mins',
                          icon: Icons.timelapse,
                        ),
                        ProgramInfoTile(
                          label: WorkoutLevel.label(program?.level ?? 0, i18n),
                          icon: Icons.fitness_center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    getExercisesReq = getExercisesReq.rebuild(
                      (b) => b
                        ..vars.queryParams.page = 1
                        ..updateResult = ((previous, result) => result),
                    );
                  });
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ShadowWrapper(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        program?.description ?? '_',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Exercises',
                      style: TextStyle(
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
                              ..vars.queryParams.page =
                                  (b.vars.queryParams.page! + 1)
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
                                response?.data?.getExercises.meta?.itemCount ==
                                    0) &&
                            getExercisesReq.vars.queryParams.page != 1) {
                          getExercisesReq = getExercisesReq.rebuild(
                            (b) => b
                              ..vars.queryParams.page =
                                  b.vars.queryParams.page! - 1,
                          );
                        }

                        if (response?.loading == true) {
                          return const SizedBox();
                        }

                        if (response?.hasErrors == true ||
                            response?.data == null) {
                          return FitnessError(
                            response: response,
                            showImage: true,
                          );
                        }

                        final data = response!.data!.getExercises;
                        final hasMoreData = data.meta!.currentPage!.toDouble() <
                            data.meta!.totalPages!.toDouble();
                        final programs = data.items;

                        if (programs?.isEmpty == true) {
                          return const FitnessEmpty(
                            showImage: true,
                            title: 'No Data',
                            message: 'Please pull to refresh to try again',
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (_, __) => const ExerciseTile(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
