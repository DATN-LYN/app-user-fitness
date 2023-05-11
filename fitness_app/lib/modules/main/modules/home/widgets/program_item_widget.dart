import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../../global/enums/workout_body_part.dart';
import '../../../../../global/enums/workout_level.dart';
import '../../../../../global/gen/i18n.dart';
import '../../../../../global/graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../../../../global/themes/app_colors.dart';

class ProgramItemWidget extends StatelessWidget {
  const ProgramItemWidget({
    super.key,
    required this.program,
  });

  final GGetProgramsData_getPrograms_items program;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final level = WorkoutLevel.getLevel(program.level ?? 0);
    final bodyPart = WorkoutBodyPart.getBodyPart(program.bodyPart ?? 0);
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
              child: CachedNetworkImage(
                imageUrl: program.imgUrl ?? '',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 90,
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
                          level.label(i18n),
                          style: const TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          program.name ?? '',
                          maxLines: 2,
                          style: const TextStyle(
                            color: AppColors.grey1,
                            fontSize: 16,
                            overflow: TextOverflow.visible,
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
