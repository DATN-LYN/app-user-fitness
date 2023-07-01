import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/program/program_item_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../global/graphql/client.dart';
import '../../../../../../../global/widgets/fitness_empty.dart';

class SearchResult extends ConsumerWidget {
  const SearchResult({
    required this.request,
    super.key,
  });
  final GGetProgramsReq request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(appClientProvider);
    var searchProgramsReq = request;
    final i18n = I18n.of(context)!;

    return InfinityList(
      client: client,
      request: searchProgramsReq,
      loadMoreRequest: (response) {
        final data = response?.data?.getPrograms;
        if (data != null &&
            data.meta!.currentPage!.toDouble() <
                data.meta!.totalPages!.toDouble()) {
          searchProgramsReq = searchProgramsReq.rebuild(
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
          return searchProgramsReq;
        }
        return null;
      },
      refreshRequest: () {
        searchProgramsReq = searchProgramsReq.rebuild(
          (b) => b
            ..vars.queryParams.page = 1
            ..updateResult = ((previous, result) => result),
        );
        return searchProgramsReq;
      },
      builder: (context, response, error) {
        if ((response?.hasErrors == true ||
                response?.data?.getPrograms.meta?.itemCount == 0) &&
            searchProgramsReq.vars.queryParams.page != 1) {
          searchProgramsReq = searchProgramsReq.rebuild(
            (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
          );
        }
        if (response?.loading == true) {
          // return const ShimmerInbox();
        }

        if (response?.hasErrors == true || response?.data == null) {
          return const SizedBox();
        }

        final data = response!.data!.getPrograms;
        final hasMoreData = data.meta!.currentPage!.toDouble() <
            data.meta!.totalPages!.toDouble();
        final programs = data.items;

        if (programs?.isEmpty == true) {
          return FitnessEmpty(
            title: i18n.common_EmptyData,
            message: i18n.programs_ProgramNotFound,
            textButton: i18n.button_TryAgain,
            onPressed: () {
              searchProgramsReq = searchProgramsReq.rebuild(
                (b) => b
                  ..vars.queryParams.page = 1
                  ..updateResult = ((previous, result) => result),
              );
            },
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: programs!.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            final item = programs[index];
            return ProgramItemLarge(
              program: item,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        );
      },
    );
  }
}
