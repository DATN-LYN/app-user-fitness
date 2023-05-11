import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.data.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/gen/i18n.dart';
import '../../global/graphql/client.dart';
import '../../global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import '../../global/utils/constants.dart';
import '../../global/widgets/fitness_empty.dart';
import '../../global/widgets/fitness_error.dart';
import 'widgets/program_item_large.dart';

class CategoryDetailPage extends ConsumerStatefulWidget {
  const CategoryDetailPage({required this.category, super.key});

  final GCategory category;

  @override
  ConsumerState<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends ConsumerState<CategoryDetailPage> {
  var getProgramsReq = GGetProgramsReq();

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

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 253, 253),
      appBar: AppBar(
        title: Text(widget.category.name ?? '_'),
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
              (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
            );
          }

          if (response?.loading == true) {
            return const ShimmerProgramList();
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
              title: 'Empty',
              message: 'Inbox is empty',
              textButton: 'Refresh',
              showImage: true,
              onPressed: refreshHandler,
            );
          }

          return ListView.separated(
            itemCount: programs!.length + (hasMoreData ? 1 : 0),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = programs[index];
              return ProgramItemLarge(program: item);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          );
        },
      ),
    );
  }
}

class ShimmerProgramList extends StatelessWidget {
  const ShimmerProgramList({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.neutral20,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(12),
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
