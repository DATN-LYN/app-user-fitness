import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class WorkoutProgramTile extends StatefulWidget {
  const WorkoutProgramTile({
    super.key,
    required this.title,
    required this.duration,
    required this.imageUrl,
  });

  final String title;
  final String duration;
  final String imageUrl;

  @override
  State<WorkoutProgramTile> createState() => _WorkoutProgramTileState();
}

class _WorkoutProgramTileState extends State<WorkoutProgramTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(const ProgramDetailRoute());
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
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
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
                          widget.duration,
                          style: const TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.title,
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
