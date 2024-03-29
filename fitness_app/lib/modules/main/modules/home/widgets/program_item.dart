import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/extensions/workout_level_extension.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../../../../global/routers/app_router.dart';
import '../../../../../global/themes/app_colors.dart';

class ProgramItem extends StatelessWidget {
  const ProgramItem({
    super.key,
    required this.program,
    this.showView = true,
  });

  final GGetProgramsData_getPrograms_items program;
  final bool showView;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return InkWell(
      onTap: () {
        context.pushRoute(ProgramDetailRoute(program: program));
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(12, 26, 75, 0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: program.imgUrl ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 90,
                  ),
                  if (showView)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.information,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Ionicons.eye_sharp,
                            color: AppColors.white,
                            size: 11,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${program.view?.toInt() ?? 0}',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.level!.label(i18n),
                          style: const TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          program.name ?? '',
                          style: const TextStyle(
                            color: AppColors.grey1,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_circle_right,
                    color: AppColors.grey1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
