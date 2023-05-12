import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/models/program_filter_data.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/widgets/program_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../../../../../../../global/gen/i18n.dart';
import '../../../../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../../../../global/themes/app_colors.dart';
import '../../../../../../../../global/widgets/filter/filter_text_field.dart';

class ProgramSearchBar extends StatefulWidget {
  const ProgramSearchBar({
    super.key,
    required this.onChanged,
    required this.request,
    required this.initialFilter,
    required ProgramFilterData programFilterData,
  });

  final ValueChanged<GGetProgramsReq> onChanged;
  final GGetProgramsReq request;
  final ProgramFilterData initialFilter;

  @override
  State<ProgramSearchBar> createState() => _ProgramSearchBarState();
}

class _ProgramSearchBarState extends State<ProgramSearchBar> {
  late ProgramFilterData filter = widget.initialFilter;

  void handleFilter(ProgramFilterData filterData) {
    filter = filterData;
    final newFilters = widget.request.vars.queryParams.filters?.toList() ?? [];

    // filter by level
    newFilters.removeWhere((e) => e.field == 'Program.level');
    if (filterData.levels.isNotEmpty) {
      newFilters.add(
        GFilterDto((b) => b
          ..field = 'Program.level'
          ..operator = GFILTER_OPERATOR.like
          ..data = filterData.levels.map((e) => e).join(',')),
      );
    }

    // filter by keyword
    newFilters.removeWhere((e) => e.field == 'Program.name');
    if (filterData.keyword?.isNotEmpty ?? false) {
      newFilters.add(
        GFilterDto(
          (b) => b
            ..field = 'Program.name'
            ..operator = GFILTER_OPERATOR.like
            ..data = filterData.keyword,
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

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: FilterTextField(
            hintText: i18n.programs_SearchHint,
            onTextChange: (text) => handleFilter(
              filter.copyWith(keyword: text),
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

              // * (Optional) show dialog on mobile
              // await showDialog(
              //   context: context,
              //   builder: (context) => Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Material(
              //       clipBehavior: Clip.hardEdge,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: RemoteFilterSheet(initialFilters: filter),
              //     ),
              //   ),
              // )

              if (newFilter is ProgramFilterData) {
                handleFilter(newFilter);
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
    );
  }
}
