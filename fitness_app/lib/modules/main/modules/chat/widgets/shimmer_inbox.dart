import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/shimmer_wrapper.dart';

class ShimmerInbox extends StatelessWidget {
  const ShimmerInbox({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
