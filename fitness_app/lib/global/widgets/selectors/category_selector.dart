import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../../../../global/utils/constants.dart';
import '../../../../../../../../global/widgets/infinity_list.dart';
import '../../graphql/client.dart';
import '../../graphql/fragment/__generated__/category_fragment.data.gql.dart';
import '../../graphql/query/__generated__/query_get_categories.req.gql.dart';
import '../../themes/app_colors.dart';
import '../shimmer_image.dart';
import 'bottom_sheet_selector.dart';
import 'dialog_selector.dart';

extension GCategoryExt on GCategory {
  Option<GCategory> get option => Option(
        label: name ?? '_',
        key: id!,
        value: this,
      );
}

class CategorySelector extends ConsumerStatefulWidget {
  const CategorySelector({
    super.key,
    required this.initial,
    this.excludeIds,
    this.onChanged,
    this.errorText,
  });

  final List<GCategory> initial;
  final List<String>? excludeIds;
  final void Function(List<Option<GCategory>> option)? onChanged;
  final String? errorText;

  @override
  ConsumerState<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends ConsumerState<CategorySelector> {
  late List<Option<GCategory>> selectedOptions =
      widget.initial.map((e) => e.option).toList();

  void showBottomSheet() {
    final client = ref.watch(appClientProvider);

    var req = GGetCategoriesReq(
      (b) => b
        ..requestId = '@getCategoriesRequestId'
        ..vars.queryParams.page = 1
        ..vars.queryParams.limit = Constants.defaultLimit,
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => InfinityList(
        client: client,
        request: req,
        refreshRequest: () {
          req = req.rebuild(
            (b) => b
              ..vars.queryParams.page = 1
              ..updateResult = ((previous, result) => result),
          );
          return req;
        },
        loadMoreRequest: (response) {
          final data = response!.data!.getCategories;
          final hasMoreData = data.meta!.currentPage! < data.meta!.totalPages!;
          if (hasMoreData) {
            req = req.rebuild(
              (b) => b
                ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
                ..updateResult = (previous, result) {
                  return previous?.rebuild(
                        (b) => b.getCategories
                          ..meta = (result?.getCategories.meta ??
                                  previous.getCategories.meta)!
                              .toBuilder()
                          ..items.addAll(result?.getCategories.items ?? []),
                      ) ??
                      result;
                },
            );
            return req;
          }
          return null;
        },
        builder: (context, response, error) {
          final i18n = I18n.of(context)!;
          final data = response?.data?.getCategories;
          final hasMoreData = data != null
              ? data.meta!.currentPage! < data.meta!.totalPages!
              : false;
          return DialogSelector<GCategory>(
            initial: selectedOptions,
            isMultiple: false,
            decoration: InputDecoration(
              hintText: i18n.categories_SearchHint,
            ),
            response: response as OperationResponse,
            hasMoreData: hasMoreData,
            tileBuilder: (option) =>
                CategorySelectorTile(category: option.value),
            options: response?.data?.getCategories.items!
                    .map((p0) => p0.option)
                    .toList()
                    .whereNot(
                        (e) => widget.excludeIds?.contains(e.value.id) ?? false)
                    .toList() ??
                [],
            onChanged: (options) {
              setState(() {
                selectedOptions = options;
              });
              widget.onChanged?.call(options);
            },
            onSearch: (keyword) async {
              req = req.rebuild(
                (p0) => p0
                  ..vars.queryParams.page = 1
                  ..updateResult = ((previous, result) => result)
                  ..vars.queryParams.filters = ListBuilder([
                    GFilterDto(
                      (b) => b
                        ..field = 'Category.name'
                        ..data = keyword
                        ..operator = GFILTER_OPERATOR.like,
                    ),
                  ]),
              );
              client.requestController.add(req);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return GestureDetector(
      onTap: showBottomSheet,
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: widget.errorText,
          contentPadding: EdgeInsets.all(selectedOptions.isEmpty ? 12 : 8),
          constraints: const BoxConstraints(minHeight: 48),
        ),
        child: selectedOptions.isEmpty
            ? Text(
                i18n.programs_ChooseCategory,
                style:
                    Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                          height: 1.35,
                        ),
              )
            : Row(
                children: [
                  ShimmerImage(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(100),
                    imageUrl: selectedOptions.first.value.imgUrl ?? '_',
                  ),
                  const SizedBox(width: 12),
                  Text(
                    selectedOptions.first.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CategorySelectorTile extends StatelessWidget {
  const CategorySelectorTile({
    super.key,
    required this.category,
  });

  final GCategory category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          ShimmerImage(
            imageUrl: category.imgUrl ?? '_',
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name ?? '_',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  category.id ?? '_',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
