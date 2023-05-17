import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../global/providers/me_provider.dart';
import '../../../../../global/themes/app_colors.dart';
import 'month_picker_dialog.dart';

class StatisticsFilter extends ConsumerStatefulWidget {
  const StatisticsFilter({
    required this.request,
    required this.onChanged,
    super.key,
  });

  final GGetMyStatsReq request;
  final Function(GGetMyStatsReq, FilterRangeType) onChanged;

  @override
  ConsumerState<StatisticsFilter> createState() => _StatisticsFilterState();
}

class _StatisticsFilterState extends ConsumerState<StatisticsFilter> {
  var selectedFilter = FilterRangeType.weekly;
  int month = Jiffy().month;

  void handleFilter(DateTime startDate, DateTime endDate) {
    final newFilters = widget.request.vars.queryParams.filters?.toList() ?? [];
    newFilters.removeWhere((e) => e.field == 'UserStatistics.updatedAt');
    newFilters.addAll(
      [
        GFilterDto(
          (b) => b
            ..data = selectedFilter.startDate().toString()
            ..field = 'UserStatistics.updatedAt'
            ..operator = GFILTER_OPERATOR.gt,
        ),
        GFilterDto(
          (b) => b
            ..data = selectedFilter.endDate().toString()
            ..field = 'UserStatistics.updatedAt'
            ..operator = GFILTER_OPERATOR.lt,
        ),
      ],
    );

    widget.onChanged(
      widget.request.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..vars.queryParams.filters = ListBuilder(newFilters)
          ..updateResult = (previous, result) => result,
      ),
      selectedFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogedIn = ref.watch(isSignedInProvider);

    return Column(
      children: [
        if (isLogedIn) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              ...FilterRangeType.values.map(
                (filter) {
                  return FilterButton(
                    isSelected: selectedFilter == filter,
                    filter: filter,
                    onFilter: () {
                      final now = DateTime.now();
                      setState(() {
                        selectedFilter = filter;
                      });
                      if (selectedFilter == FilterRangeType.monthly) {
                        handleFilter(
                          selectedFilter.startDate(month: month) ?? now,
                          selectedFilter.startDate(month: month) ?? now,
                        );
                      } else {
                        handleFilter(
                          selectedFilter.startDate() ?? now,
                          selectedFilter.endDate() ?? now,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
          if (selectedFilter == FilterRangeType.monthly)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FormBuilderField<int>(
                name: 'month',
                initialValue: Jiffy().month,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                ),
                builder: (field) {
                  return MonthPickerDialog(
                    onChanged: (selectedMonth) {
                      if (selectedMonth != null) {
                        month = selectedMonth.month;
                      }
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 32),
        ],
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.filter,
    this.isSelected = false,
    required this.onFilter,
  });

  final FilterRangeType filter;
  final bool isSelected;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: onFilter,
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryBold
                : AppColors.primary.withOpacity(0.7),
          ),
          child: Text(
            filter.label(i18n),
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.grey1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
