import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:fitness_app/global/extensions/workout_level_extension.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/themes/app_colors.dart';
import '../../../../../../../../global/widgets/filter/filter_sheet_wrapper.dart';
import '../models/program_filter_data.dart';

class ProgramFilterSheet extends StatefulWidget {
  const ProgramFilterSheet({
    super.key,
    required this.programFilterData,
  });

  final ProgramFilterData programFilterData;

  @override
  State<ProgramFilterSheet> createState() => _ProgramFilterSheetState();
}

class _ProgramFilterSheetState extends State<ProgramFilterSheet> {
  late ProgramFilterData filter = widget.programFilterData;

  void handleClearFilter() {
    setState(() {
      filter = const ProgramFilterData();
    });
  }

  TextStyle get titleStyle => const TextStyle(
        color: AppColors.grey1,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return FilterSheetWrapper(
      onApply: () => context.popRoute(filter),
      onClearAll: handleClearFilter,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Level',
            style: titleStyle,
          ),
        ),
        const SizedBox(height: 10),
        ...GWORKOUT_LEVEL.values.map(
          (e) => CheckboxListTile(
            value: filter.levels.contains(e),
            title: Text(e.label(i18n)),
            onChanged: (value) {
              setState(
                () {
                  if (value == true) {
                    filter = filter.copyWith(levels: [...filter.levels, e]);
                  } else {
                    filter = filter.copyWith(
                      levels:
                          filter.levels.whereNot((item) => item == e).toList(),
                    );
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
