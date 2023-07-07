import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/widgets/program/shimmer_program_large_list.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/models/program_filter_data.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/widgets/program_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../global/gen/i18n.dart';
import '../../../../../../../global/graphql/client.dart';
import '../../../../../../../global/utils/constants.dart';
import '../../../../../../../global/utils/debouncer.dart';
import '../../../../../../../global/widgets/fitness_empty.dart';
import '../../../../../../../global/widgets/fitness_error.dart';
import '../../../../../../../global/widgets/infinity_list.dart';
import '../../../../../../../global/widgets/program/program_item_large.dart';

class ProgramListPage extends ConsumerStatefulWidget {
  const ProgramListPage({
    super.key,
    required this.isNewest,
  });

  final bool isNewest;

  @override
  ConsumerState<ProgramListPage> createState() => _ProgramListPageState();
}

class _ProgramListPageState extends ConsumerState<ProgramListPage> {
  final searchController = TextEditingController();
  final debouncer = Debouncer();
  final initialFilter = const ProgramFilterData();
  late var getProgramsReq = GGetProgramsReq(
    (b) => b
      ..requestId = '@getProgramsRequestId'
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.orderBy =
          widget.isNewest ? 'Program.createdAt:DESC' : 'Program.view:DESC',
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

  void handleFilterChange(GGetProgramsReq newReq) {
    setState(
      () => getProgramsReq = getProgramsReq.rebuild((b) => b
        ..vars.queryParams.filters =
            newReq.vars.queryParams.filters?.toBuilder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 253, 253),
      appBar: AppBar(
        title: Text(i18n.programs_Programs),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            ProgramSearchBar(
              initialFilter: initialFilter,
              onChanged: (newReq) => handleFilterChange(newReq),
              request: GGetProgramsReq(
                (b) => b
                  ..vars.queryParams =
                      getProgramsReq.vars.queryParams.toBuilder(),
              ),
            ),
            Expanded(
              child: InfinityList(
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
                                ..items.addAll(result?.getPrograms.items ?? []),
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
                      (b) => b
                        ..vars.queryParams.page = b.vars.queryParams.page! - 1,
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: programs!.length,
                    itemBuilder: (context, index) {
                      final item = programs[index];
                      return ProgramItemLarge(program: item);
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
