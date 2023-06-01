import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../global/gen/i18n.dart';
import '../../../../../../global/themes/app_colors.dart';
import '../../../../../../global/widgets/elevated_button_opacity.dart';

class DateTimeRangePickerDialog extends StatefulWidget {
  const DateTimeRangePickerDialog({
    super.key,
    required this.onChanged,
    this.initialStartDate,
    this.initialEndDate,
  });

  final Function(PickerDateRange?) onChanged;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  @override
  State<DateTimeRangePickerDialog> createState() =>
      _DateTimeRangePickerDialogState();
}

class _DateTimeRangePickerDialogState extends State<DateTimeRangePickerDialog> {
  late DateTime startDate = widget.initialStartDate ?? DateTime.now();
  late DateTime endDate = widget.initialEndDate ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final scrW = MediaQuery.of(context).size.width;

    void showDialogPicker() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: min(300, scrW * 0.8),
              height: min(300, scrW * 0.8),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: SfDateRangePicker(
                      selectionColor: AppColors.primaryBold,
                      todayHighlightColor: AppColors.primaryBold,
                      allowViewNavigation: true,
                      initialSelectedRange: PickerDateRange(startDate, endDate),
                      onSelectionChanged: (selectedDate) {
                        if (selectedDate.value is PickerDateRange) {
                          final dateRange =
                              selectedDate.value as PickerDateRange;
                          setState(
                            () {
                              startDate =
                                  dateRange.startDate?.combineTime(startDate) ??
                                      startDate;
                              endDate =
                                  dateRange.endDate?.combineTime(endDate) ??
                                      startDate.combineTime(endDate);
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButtonOpacity(
                          onTap: () {
                            context.popRoute();
                            widget.onChanged(null);
                          },
                          color: AppColors.grey6,
                          label: i18n.button_Cancel,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButtonOpacity(
                          onTap: () {
                            context.popRoute();
                            widget
                                .onChanged(PickerDateRange(startDate, endDate));
                          },
                          label: i18n.button_Done,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return InputDecorator(
      decoration: const InputDecoration(
        suffixIcon: Icon(
          Icons.arrow_drop_down_sharp,
          size: 30,
          color: AppColors.grey1,
        ),
      ),
      child: InkWell(
        onTap: showDialogPicker,
        child: Text(
          '${startDate.formatDate()} - ${endDate.formatDate()}',
        ),
      ),
    );
  }
}
