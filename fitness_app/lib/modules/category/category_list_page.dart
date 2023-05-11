import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.req.gql.dart';
import 'package:fitness_app/modules/category/widgets/category_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/graphql/client.dart';
import '../../global/utils/constants.dart';
import '../../global/widgets/fitness_empty.dart';
import '../../global/widgets/fitness_error.dart';
import '../../global/widgets/infinity_list.dart';

class CategoryListPage extends ConsumerStatefulWidget {
  const CategoryListPage({super.key});

  @override
  ConsumerState<CategoryListPage> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends ConsumerState<CategoryListPage> {
  var getCategoriesReq = GGetCategoriesReq(
    (b) => b
      ..requestId = '@getCategoriesRequestId'
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.orderBy = 'Category.createdAt:DESC',
  );

  void refreshHanlder() {
    setState(() {
      getCategoriesReq = getCategoriesReq.rebuild(
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
        title: Text(i18n.categories_Categories),
      ),
      body: InfinityList(
        client: client,
        request: getCategoriesReq,
        loadMoreRequest: (response) {
          final data = response?.data?.getCategories;
          if (data != null &&
              data.meta!.currentPage!.toDouble() <
                  data.meta!.totalPages!.toDouble()) {
            getCategoriesReq = getCategoriesReq.rebuild(
              (b) => b
                ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
                ..updateResult = (previous, result) =>
                    previous?.rebuild(
                      (b) => b.getCategories
                        ..meta = (result?.getCategories.meta ??
                                previous.getCategories.meta)!
                            .toBuilder()
                        ..items.addAll(result?.getCategories.items ?? []),
                    ) ??
                    result,
            );
            return getCategoriesReq;
          }
          return null;
        },
        refreshRequest: () {
          getCategoriesReq = getCategoriesReq.rebuild(
            (b) => b
              ..vars.queryParams.page = 1
              ..updateResult = ((previous, result) => result),
          );
          return getCategoriesReq;
        },
        builder: (context, response, error) {
          if ((response?.hasErrors == true ||
                  response?.data?.getCategories.meta?.itemCount == 0) &&
              getCategoriesReq.vars.queryParams.page != 1) {
            getCategoriesReq = getCategoriesReq.rebuild(
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
                // return const ShimmerRemoteTile();
                return const SizedBox();
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          }
          final data = response!.data!.getCategories;
          final hasMoreData = data.meta!.currentPage!.toDouble() <
              data.meta!.totalPages!.toDouble();
          final categories = data.items;

          if (categories?.isEmpty == true) {
            return FitnessEmpty(
              title: i18n.categories_CategoryNotFound,
            );
          }

          return ListView.separated(
            itemCount: categories!.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = categories[index];
              return CategoryItemRow(category: item);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          );
        },
      ),
    );
  }
}
