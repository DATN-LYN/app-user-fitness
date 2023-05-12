import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/search/providers/history_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import '../../../../global/utils/constants.dart';
import '../../../../global/utils/debouncer.dart';
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
  final debouncer = Debouncer(duration: const Duration(milliseconds: 300));
  late final keywordProvider = ref.read(searchKeywordProvider.notifier);

  var searchProgramsReq = GGetProgramsReq(
    (b) => b
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.page = 1
      ..vars.queryParams.orderBy = 'Program.createdAt:DESC',
  );

  void onChanged(String text) async {
    debouncer.run(() {
      keywordProvider.update((state) => text);
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
    newFilters.removeWhere((e) => e.field == 'Program.name');
    final keyword = ref.read(searchKeywordProvider);
    if (keyword.isNotEmpty) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Program.name'
            ..operator = GFILTER_OPERATOR.like
            ..data = keyword,
        ),
      );
    }
    setState(
      () => searchProgramsReq = searchProgramsReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..vars.queryParams.filters = ListBuilder(newFilters)
          ..vars.queryParams.orderBy =
              searchProgramsReq.vars.queryParams.orderBy
          ..updateResult = ((previous, result) => result),
      ),
    );
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
        ),
      ),
      body: ref.watch(searchKeywordProvider).isNotEmpty
          ? SearchResult(
              request: searchProgramsReq,
            )
          : SearchHistory(
              onTap: (String text) {
                setState(() => textController.text = text);
                keywordProvider.update((state) => text);
              },
            ),
    );
  }
}
