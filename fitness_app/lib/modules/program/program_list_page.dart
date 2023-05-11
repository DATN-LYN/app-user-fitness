import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/modules/category/category_detail_page.dart';
import 'package:fitness_app/modules/category/widgets/program_item_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/gen/i18n.dart';
import '../../global/graphql/client.dart';
import '../../global/utils/constants.dart';
import '../../global/widgets/fitness_empty.dart';
import '../../global/widgets/fitness_error.dart';
import '../../global/widgets/infinity_list.dart';

class ProgramListPage extends ConsumerStatefulWidget {
  const ProgramListPage({super.key});

  @override
  ConsumerState<ProgramListPage> createState() => _ProgramListPageState();
}

class _ProgramListPageState extends ConsumerState<ProgramListPage> {
  var getProgramsReq = GGetProgramsReq(
    (b) => b
      ..requestId = '@getProgramsRequestId'
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = Constants.defaultLimit
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
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.programs_Programs),
      ),
      body: InfinityList(
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
              (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
            );
          }

          if (response?.hasErrors == true) {
            return FitnessError(response: response);
          }

          if (response?.loading ?? false) {
            return ListView.separated(
              itemCount: 3,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemBuilder: (context, index) {
                return const ShimmerProgramList();
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          }
          final data = response!.data!.getPrograms;
          final hasMoreData = data.meta!.currentPage!.toDouble() <
              data.meta!.totalPages!.toDouble();
          final programs = data.items;

          if (programs?.isEmpty == true) {
            return FitnessEmpty(
              title: i18n.categories_CategoryNotFound,
              onPressed: refreshHanlder,
            );
          }

          return ListView.builder(
            itemCount: programs!.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = programs[index];
              return ProgramItemLarge(program: item);
            },
          );
        },
      ),
    );
  }
}
