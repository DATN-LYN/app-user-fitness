import 'package:flutter/material.dart';

import '../../../../../../../../global/themes/app_colors.dart';
import '../../../../../../../../global/widgets/shimmer_wrapper.dart';

class ShimmerExerciseList extends StatelessWidget {
  const ShimmerExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.neutral20,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 15,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 15,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      ),
    );
  }
}
