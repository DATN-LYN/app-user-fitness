import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.req.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_program.req.gql.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/utils/dialogs.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:fitness_app/modules/program/widgets/program_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/graphql/client.dart';
import '../../global/graphql/query/__generated__/query_get_program.data.gql.dart';

class ProgramDetailPage extends ConsumerStatefulWidget {
  const ProgramDetailPage({
    super.key,
    required this.program,
  });

  final GProgram program;

  @override
  ConsumerState<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends ConsumerState<ProgramDetailPage> {
  GGetProgramData_getProgram? program;
  bool loading = false;
  var key = GlobalKey();

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
      setState(() => program = res.data!.getProgram);
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
                        if (loading)
                          ShimmerWrapper(
                            child: Container(
                              width: 120,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        else
                          Text(
                            program?.name ?? '_',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                key: key,
                onRefresh: () async {
                  setState(() {
                    key = GlobalKey();
                  });
                },
                child: ProgramDetailBody(program: program),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
