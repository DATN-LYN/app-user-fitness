import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/enums/filter_range_type.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart';
import 'package:fitness_app/modules/main/modules/statistics/models/statistics_filter_data.dart';
import 'package:fitness_app/modules/main/modules/statistics/widgets/dialogs/date_time_range_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../global/themes/app_colors.dart';
import 'dialogs/month_picker_dialog.dart';
import 'dialogs/year_picker_dialog.dart';

class StatisticsFilter extends ConsumerStatefulWidget {
  const StatisticsFilter({
    required this.request,
    required this.onChanged,
    required this.filter,
    super.key,
  });

  final GGetMyStatsReq request;
  final Function(GGetMyStatsReq, StatisticsFilterData) onChanged;
  final StatisticsFilterData filter;

  @override
  ConsumerState<StatisticsFilter> createState() => _StatisticsFilterState();
}

class _StatisticsFilterState extends ConsumerState<StatisticsFilter> {
  late var filter = widget.filter;

  void handleFilter(DateTime startDate, DateTime endDate) {
    final newFilters = widget.request.vars.queryParams.filters?.toList() ?? [];
    newFilters.removeWhere((e) => e.field == 'UserStatistics.updatedAt');
    newFilters.addAll(
      [
        GFilterDto(
          (b) => b
            ..data = startDate.toString()
            ..field = 'UserStatistics.updatedAt'
            ..operator = GFILTER_OPERATOR.gt,
        ),
        GFilterDto(
          (b) => b
            ..data = endDate.toString()
            ..field = 'UserStatistics.updatedAt'
            ..operator = GFILTER_OPERATOR.lt,
        ),
      ],
    );

    widget.onChanged(
      widget.request.rebuild(
        (b) => b
          ..vars.queryParams.filters = ListBuilder(newFilters)
          ..updateResult = (previous, result) => result,
      ),
      filter,
    );
  }

  void onFilter() {
    final now = DateTime.now();

    handleFilter(
      filter.startDate ?? now,
      filter.startDate ?? now,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            ...FilterRangeType.values.map(
              (rangeType) {
                return FilterButton(
                  isSelected: filter.rangeType == rangeType,
                  filter: rangeType,
                  onFilter: () {
                    setState(() {
                      filter = filter.copyWith(rangeType: rangeType);
                    });

                    onFilter();
                  },
                );
              },
            ),
          ],
        ),
        if (filter.rangeType == FilterRangeType.monthly)
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
                  initialValue: filter.rangeType?.getFirstDayOfMonth(
                    filter.month ?? Jiffy().month,
                  ),
                  onChanged: (selectedTime) {
                    if (selectedTime != null) {
                      setState(() {
                        filter = filter.copyWith(
                          month: selectedTime.month,
                          startDate: filter.rangeType
                              ?.startDate(month: selectedTime.month),
                          endDate: filter.rangeType
                              ?.endDate(month: selectedTime.month),
                        );
                      });
                      onFilter();
                    }
                  },
                );
              },
            ),
          ),
        if (filter.rangeType == FilterRangeType.yearly)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FormBuilderField<int>(
              name: 'year',
              initialValue: Jiffy().month,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 30,
                ),
              ),
              builder: (field) {
                return YearPickerDialog(
                  initialValue: filter.rangeType?.getFirstDayOfMonth(
                    filter.month ?? Jiffy().month,
                  ),
                  onChanged: (selectedMonth) {
                    if (selectedMonth != null) {
                      setState(() {
                        filter = filter.copyWith(year: selectedMonth.year);
                      });
                      onFilter();
                    }
                  },
                );
              },
            ),
          ),
        if (filter.rangeType == FilterRangeType.advanced)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FormBuilderField<PickerDateRange>(
              name: 'advanced',
              initialValue: PickerDateRange(filter.startDate, filter.endDate),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 30,
                ),
              ),
              builder: (field) {
                return DateTimeRangePickerDialog(
                  initialStartDate: filter.startDate,
                  initialEndDate: filter.endDate,
                  onChanged: (selectedTime) {
                    if (selectedTime != null) {
                      setState(() {
                        filter = filter.copyWith(
                          startDate: selectedTime.startDate,
                          endDate: selectedTime.endDate,
                        );
                      });
                      onFilter();
                    }
                  },
                );
              },
            ),
          ),
        const SizedBox(height: 32),
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
        padding: const EdgeInsets.symmetric(horizontal: 2),
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
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
