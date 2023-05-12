import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.req.gql.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../../../../global/widgets/filter/filter_text_field.dart';

class CategorySearchBar extends StatefulWidget {
  const CategorySearchBar({
    super.key,
    required this.onChanged,
    required this.request,
  });

  final ValueChanged<GGetCategoriesReq> onChanged;
  final GGetCategoriesReq request;

  @override
  State<CategorySearchBar> createState() => _CategorySearchBarState();
}

class _CategorySearchBarState extends State<CategorySearchBar> {
  void handleFilter(String? keyword) {
    final newFilters = widget.request.vars.queryParams.filters?.toList() ?? [];

    // filter by keyword
    newFilters.removeWhere((e) => e.field == 'Category.name');
    if (keyword?.isNotEmpty ?? false) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Category.name'
            ..operator = GFILTER_OPERATOR.like
            ..data = keyword,
        ),
      );
    }

    widget.onChanged(widget.request.rebuild(
      (b) => b
        ..vars.queryParams.page = 1
        ..vars.queryParams.filters = ListBuilder(newFilters)
        ..updateResult = (previous, result) => result,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return FilterTextField(
      hintText: i18n.programs_SearchHint,
      onTextChange: (text) => handleFilter(text),
    );
  }
}
