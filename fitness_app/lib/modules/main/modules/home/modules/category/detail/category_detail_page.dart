import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.data.gql.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/widgets/program_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../global/gen/i18n.dart';
import '../../../../../../../global/graphql/client.dart';
import '../../../../../../../global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import '../../../../../../../global/utils/constants.dart';
import '../../../../../../../global/widgets/fitness_empty.dart';
import '../../../../../../../global/widgets/fitness_error.dart';
import '../../../../../../../global/widgets/program/program_item_large.dart';
import '../../../../../../../global/widgets/program/shimmer_program_large_list.dart';
import '../../program/list/models/program_filter_data.dart';

class CategoryDetailPage extends ConsumerStatefulWidget {
  const CategoryDetailPage({required this.category, super.key});

  final GCategory category;

  @override
  ConsumerState<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends ConsumerState<CategoryDetailPage> {
  var getProgramsReq = GGetProgramsReq();
  final initialFilter = const ProgramFilterData();

  @override
  void initState() {
    getProgramsReq = GGetProgramsReq(
      (b) => b
        ..requestId = '@getProgramsByDetailReq'
        ..vars.queryParams.limit = Constants.defaultLimit
        ..vars.queryParams.page = 1
        ..vars.queryParams.orderBy = 'Program.createdAt:DESC'
        ..vars.queryParams.filters = ListBuilder(
          [
            GFilterDto(
              (b) => b
                ..data = widget.category.id
                ..field = 'Program.categoryId'
                ..operator = GFILTER_OPERATOR.eq,
            )
          ],
        ),
    );
    super.initState();
  }

  void refreshHandler() {
    setState(
      () => getProgramsReq = getProgramsReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      ),
    );
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
        title: Text(widget.category.name ?? '_'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            ProgramSearchBar(
              onChanged: (newReq) => handleFilterChange(newReq),
              request: GGetProgramsReq(
                (b) => b
                  ..vars.queryParams =
                      getProgramsReq.vars.queryParams.toBuilder(),
              ),
              initialFilter: initialFilter,
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
                builder: (context, response, err) {
                  if ((response?.hasErrors == true ||
                          response?.data?.getPrograms.meta?.itemCount == 0) &&
                      getProgramsReq.vars.queryParams.page != 1) {
                    getProgramsReq = getProgramsReq.rebuild(
                      (b) => b
                        ..vars.queryParams.page = b.vars.queryParams.page! - 1,
                    );
                  }

                  if (response?.loading == true) {
                    return const ShimmerProgramLargeList();
                  }

                  if (response?.hasErrors == true || response?.data == null) {
                    return FitnessError(response: response);
                  }

                  final data = response!.data!.getPrograms;
                  final hasMoreData = data.meta!.currentPage!.toDouble() <
                      data.meta!.totalPages!.toDouble();
                  final programs = data.items;

                  if (programs?.isEmpty == true) {
                    return FitnessEmpty(
                      title: i18n.common_EmptyData,
                      message: i18n.programs_ProgramNotFound,
                      textButton: 'Refresh',
                      showImage: true,
                      onPressed: refreshHandler,
                    );
                  }

                  return ListView.separated(
                    itemCount: programs!.length + (hasMoreData ? 1 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
