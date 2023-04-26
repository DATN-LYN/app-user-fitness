import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.req.gql.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/graphql/client.dart';
import '../../../../../global/widgets/fitness_empty.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  var getCategoriesReq = GGetCateforiesReq(
    (b) => b
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1,
  );
  void refreshHandler() {
    setState(
      () => getCategoriesReq = getCategoriesReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(appClientProvider);

    return InfinityList(
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
                      ..items.addAll(
                        result?.getCategories.items ?? [],
                      ),
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

        if (response?.loading == true) {
          print('LOADING....');
          // return const ShimmerInbox();
        }

        if (response?.hasErrors == true || response?.data == null) {
          // return FitnessError(response: response);
          print(response?.graphqlErrors?.first);
          return const SizedBox();
        }

        final data = response!.data!.getCategories;
        final hasMoreData = data.meta!.currentPage!.toDouble() <
            data.meta!.totalPages!.toDouble();
        final categories = data.items;

        if (categories?.isEmpty == true) {
          return FitnessEmpty(
            title: 'Empty',
            message: 'Inbox is empty',
            textButton: 'Refresh',
            image: Assets.images.sadFace.image(height: 100),
            onPressed: refreshHandler,
          );
        }

        return ListView.separated(
          itemCount: categories!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = categories[index];
            return CategoryItemWidget(
              category: item,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        );
      },
    );
  }
}
