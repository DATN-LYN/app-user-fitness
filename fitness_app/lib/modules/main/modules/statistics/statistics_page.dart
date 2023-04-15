import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/enums/schedule_filter.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../global/themes/app_colors.dart';
import 'widgets/statistics_body_data.dart';
import 'widgets/statistics_chart.dart';
import 'widgets/statistics_recently_workout.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  ScheduleFilter selectedSchedule = ScheduleFilter.weekly;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.main_Statistics),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              _filterItem(schedule: ScheduleFilter.weekly),
              _filterItem(schedule: ScheduleFilter.monthly),
              _filterItem(schedule: ScheduleFilter.yearly),
            ],
          ),
          if (selectedSchedule == ScheduleFilter.monthly)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FormBuilderField(
                name: 'month',
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                ),
                builder: (field) {
                  return const MonthPickerDialog();
                },
              ),
            ),
          const SizedBox(height: 32),
          const StatisticsBodyData(),
          const SizedBox(height: 32),
          RichText(
            text: TextSpan(
              text: '${i18n.statistics_YouHaveBurnt} ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey1,
              ),
              children: [
                TextSpan(
                  text: '1290 ${i18n.statistics_Calories} ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBold,
                  ),
                ),
                TextSpan(text: '${i18n.statistics_ThisMonth}.'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            i18n.statistics_WhatAGreatValue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const StatisticsChart(),
          const SizedBox(height: 32),
          Text(
            i18n.statistics_RecentWorkout,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const StatisticsRecentlyWorkout(),
        ],
      ),
    );
  }

  Widget _filterItem({required ScheduleFilter schedule}) {
    final isSelected = selectedSchedule == schedule;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton(
          onPressed: () {
            setState(() {
              selectedSchedule = schedule;
            });
          },
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.primaryBold
                : AppColors.primary.withOpacity(0.7),
          ),
          child: Text(
            schedule.value,
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

class MonthPickerDialog extends StatelessWidget {
  const MonthPickerDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    void showDialogPicker() {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SfDateRangePicker(
                      view: DateRangePickerView.year,
                      initialSelectedRange: PickerDateRange(
                        DateTime.now(),
                        DateTime.now(),
                      ),
                      selectionColor: AppColors.primaryBold,
                      todayHighlightColor: AppColors.primaryBold,
                      allowViewNavigation: false,
                      // minDate: widget.minDate,
                      // maxDate: widget.maxDate,
                      onSelectionChanged: (selectedDate) {
                        if (selectedDate.value is PickerDateRange) {
                          final dateRange =
                              selectedDate.value as PickerDateRange;
                          // setState(
                          //   () {
                          //     startDate =
                          //         dateRange.startDate?.combineTime(startDate) ??
                          //             startDate;
                          //     endDate = dateRange.endDate?.combineTime(endDate) ??
                          //         startDate.combineTime(endDate);
                          //   },
                          // );
                        }
                      },
                      // selectableDayPredicate: (DateTime val) =>
                      //     !widget.excludeWeekDay.contains(val.weekday),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: context.popRoute,
                            child: Text(i18n.button_Cancel),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(i18n.button_Done),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    return InputDecorator(
      decoration: const InputDecoration(),
      child: InkWell(
        child: Text(i18n.statistics_SelectMonth),
        onTap: () => showDialogPicker(),
      ),
    );
  }
}
