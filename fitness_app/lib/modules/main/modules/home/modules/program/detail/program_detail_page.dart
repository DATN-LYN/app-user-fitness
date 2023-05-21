import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/detail/widgets/program_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../global/graphql/client.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);

    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
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
                              width: 200,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        else
                          Text(
                            widget.program.name ?? '_',
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
                child: ProgramDetailBody(
                  program: widget.program,
                  loading: loading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
