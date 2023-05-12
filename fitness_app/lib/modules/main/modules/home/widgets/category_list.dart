import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/constants.dart';
import 'package:fitness_app/global/widgets/fitness_empty.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/graphql/client.dart';
import '../../../../../global/widgets/fitness_error.dart';
import 'category_item.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  var getCategoriesReq = GGetCategoriesReq(
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
    final i18n = I18n.of(context)!;

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
          return const ShimmerWrapper(
            child: ShimmerCategoryList(),
          );
        }

        if (response?.hasErrors == true || response?.data == null) {
          return FitnessError(
            response: response,
            showImage: false,
          );
        }

        final data = response!.data!.getCategories;
        data.meta!.totalPages!.toDouble();
        final categories = data.items;

        if (categories?.isEmpty == true) {
          return FitnessEmpty(
            title: i18n.categories_CategoryNotFound,
            message: i18n.common_PleasePullToTryAgain,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 2),
          itemCount: categories!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = categories[index];
            return CategoryItem(
              category: item,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        );
      },
    );
  }
}

class ShimmerCategoryList extends StatelessWidget {
  const ShimmerCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.grey6,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColors.grey6,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
