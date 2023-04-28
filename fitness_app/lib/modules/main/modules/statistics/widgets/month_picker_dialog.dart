import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/elevated_button_opacity.dart';

class MonthPickerDialog extends StatelessWidget {
  const MonthPickerDialog({
    super.key,
    required this.onChanged,
  });

  final Function(DateTime?) onChanged;

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
                      selectionColor: AppColors.primaryBold,
                      todayHighlightColor: AppColors.primaryBold,
                      allowViewNavigation: false,
                      initialSelectedDate: DateTime.now(),
                      onSelectionChanged: (selectedDate) {
                        onChanged(selectedDate as DateTime);
                        // setState(
                        //   () {
                        //     startDate =
                        //         dateRange.startDate?.combineTime(startDate) ??
                        //             startDate;
                        //     endDate = dateRange.endDate?.combineTime(endDate) ??
                        //         startDate.combineTime(endDate);
                        //   },
                        // );
                      },
                      // selectableDayPredicate: (DateTime val) =>
                      //     !widget.excludeWeekDay.contains(val.weekday),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButtonOpacity(
                            onTap: () {
                              context.popRoute();
                              onChanged(null);
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
          });
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
        child: Text(i18n.statistics_SelectMonth),
        onTap: () => showDialogPicker(),
      ),
    );
  }
}
