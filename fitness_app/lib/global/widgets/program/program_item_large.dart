import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/extensions/body_part_extension.dart';
import 'package:fitness_app/global/extensions/workout_level_extension.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:fitness_app/global/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../gen/i18n.dart';
import '../../routers/app_router.dart';

class ProgramItemLarge extends StatelessWidget {
  const ProgramItemLarge({
    super.key,
    required this.program,
  });

  final GProgram program;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

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
              fit: BoxFit.cover,
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
                        text: program.level!.label(i18n),
                        color: program.level!.color(),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  _infoTile(
                    icon: Ionicons.body,
                    label: '${i18n.common_BodyPart}: ',
                    value: program.bodyPart!.label(i18n),
                  ),
                  _infoTile(
                    icon: Ionicons.document_text,
                    label: '${i18n.common_Description}: ',
                    value: program.description ?? '_',
                  ),
                  _infoTile(
                    icon: Ionicons.eye,
                    label: '${i18n.programs_View}: ',
                    value: '${program.view?.toInt() ?? 0} ',
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
