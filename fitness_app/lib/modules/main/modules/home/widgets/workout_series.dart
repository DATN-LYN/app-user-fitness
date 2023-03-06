import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class WorkoutSeries extends StatefulWidget {
  const WorkoutSeries({
    super.key,
    required this.title,
    required this.duration,
    required this.imageUrl,
  });

  final String title;
  final String duration;
  final String imageUrl;

  @override
  State<WorkoutSeries> createState() => _WorkoutSeriesState();
}

class _WorkoutSeriesState extends State<WorkoutSeries> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.imageUrl),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(10)),
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
                    color: AppColors.white,
                    fontSize: 15,
                    overflow: TextOverflow.visible,
                  ),
                ),
                Text(
                  widget.title,
                  maxLines: 2,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_circle_right,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
