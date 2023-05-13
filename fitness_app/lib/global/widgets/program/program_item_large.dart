import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/enums/workout_level.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:fitness_app/global/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../enums/workout_body_part.dart';
import '../../gen/i18n.dart';
import '../../graphql/query/__generated__/query_get_programs.data.gql.dart';
import '../../routers/app_router.dart';

class ProgramItemLarge extends StatelessWidget {
  const ProgramItemLarge({
    super.key,
    required this.program,
  });

  final GGetProgramsData_getPrograms_items program;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final level = WorkoutLevel.getLevel(program.level ?? 0);
    final bodyPart = WorkoutBodyPart.getBodyPart(program.bodyPart ?? 0);
    const textStyle = TextStyle(
      color: AppColors.grey2,
    );
    return ShadowWrapper(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => context.pushRoute(
          ProgramDetailRoute(program: program),
        ),
        child: Column(
          children: [
            ShimmerImage(
              imageUrl: program.imgUrl ?? '_',
              height: 150,
              width: double.infinity,
              fit: BoxFit.fill,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        program.name ?? '_',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Tag(
                        text: level.label(i18n),
                        color: level.color(),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  _infoTile(
                    icon: Ionicons.body,
                    label: '${i18n.common_BodyPart}: ',
                    value: bodyPart.label(i18n),
                  ),
                  _infoTile(
                    icon: Ionicons.document_text,
                    label: '${i18n.common_Description}: ',
                    value: program.description ?? '_',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
