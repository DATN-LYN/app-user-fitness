import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/home/modules/search/providers/history_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../../global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import '../../../../../../global/utils/constants.dart';
import '../../../../../../global/utils/debouncer.dart';
import '../../../../../../global/widgets/shadow_wrapper.dart';
import '../program/list/models/program_filter_data.dart';
import '../program/list/widgets/program_filter_sheet.dart';
import 'providers/search_keyword_provider.dart';
import 'widgets/search_history.dart';
import 'widgets/search_result.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final textController = TextEditingController();
  final debouncer = Debouncer(duration: const Duration(milliseconds: 200));
  late final keywordProvider = ref.read(searchKeywordProvider.notifier);
  ProgramFilterData filter = const ProgramFilterData();
  var searchProgramsReq = GGetProgramsReq(
    (b) => b
      ..requestId = '@getProgramsSearchRequestId'
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1
      ..vars.queryParams.orderBy = 'Program.createdAt:DESC',
  );

  void onChanged(String? text) async {
    debouncer.run(() {
      keywordProvider.update((state) => text ?? '');
      onSearch();
    });
  }

  void goBack() {
    FocusManager.instance.primaryFocus?.unfocus();
    context.popRoute();
  }

  void onSubmit() {
    ref.read(historySearchProvider.notifier).addItemHistory(
          ref.read(searchKeywordProvider),
        );
    onSearch();
  }

  void onSearch() {
    final newFilters =
        searchProgramsReq.vars.queryParams.filters?.toList() ?? [];
    final filterData = filter;

    newFilters.removeWhere((e) => e.field == 'Program.name');
    final keyword = ref.watch(searchKeywordProvider);
    newFilters.add(
      GFilterDto(
        (b) => b
          ..field = 'Program.name'
          ..operator = GFILTER_OPERATOR.like
          ..data = keyword,
      ),
    );

    // filter by level
    newFilters.removeWhere((e) => e.field == 'Program.level');
    if (filterData.levels.isNotEmpty == true) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Program.level'
            ..operator = GFILTER_OPERATOR.Gin
            ..data = filterData.levels.map((e) => e).join(','),
        ),
      );
    }

    // filter by bodyPart
    newFilters.removeWhere((e) => e.field == 'Program.bodyPart');
    if (filterData.bodyPart != null) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Program.bodyPart'
            ..operator = GFILTER_OPERATOR.eq
            ..data = filterData.bodyPart.toString(),
        ),
      );
    }

    // filter by categoryId
    newFilters.removeWhere((e) => e.field == 'Program.categoryId');
    if (filterData.category != null) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Program.categoryId'
            ..operator = GFILTER_OPERATOR.eq
            ..data = filterData.category?.id,
        ),
      );
    }

    setState(() {
      searchProgramsReq = searchProgramsReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..vars.queryParams.filters = ListBuilder(newFilters)
          ..vars.queryParams.orderBy =
              searchProgramsReq.vars.queryParams.orderBy
          ..updateResult = ((previous, result) => result),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Hero(
          tag: 'HomeAppBar',
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    autofocus: true,
                    onFieldSubmitted: (_) => onSubmit(),
                    onChanged: onChanged,
                    textInputAction: TextInputAction.search,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      hintText: i18n.programs_SearchHint,
                      hintStyle: const TextStyle(color: AppColors.grey3),
                      prefixIconConstraints: const BoxConstraints(),
                      prefixIcon: SizedBox.square(
                        dimension: 40,
                        child: IconButton(
                          onPressed: goBack,
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ShadowWrapper(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  child: IconButton(
                    onPressed: () async {
                      final newFilter = await SideSheet.right(
                        body: ProgramFilterSheet(programFilterData: filter),
                        context: context,
                        width: min(
                          MediaQuery.of(context).size.width * 0.8,
                          400,
                        ),
                      );

                      if (newFilter is ProgramFilterData) {
                        setState(() {
                          filter = newFilter;
                        });
                        onSearch();
                      }
                    },
                    icon: const Icon(
                      Icons.filter_alt_rounded,
                      color: AppColors.grey3,
                      size: 16,
                    ),
                    hoverColor: AppColors.grey6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ref.watch(searchKeywordProvider).isNotEmpty ||
              filter != const ProgramFilterData()
          ? SearchResult(
              request: searchProgramsReq,
            )
          : SearchHistory(
              onTap: (String text) {
                setState(() => textController.text = text);
                keywordProvider.update((state) => text);
                onSearch();
              },
            ),
    );
  }
}
