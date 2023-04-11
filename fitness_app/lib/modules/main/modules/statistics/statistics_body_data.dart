import 'package:flutter/material.dart';

import '../../../../global/themes/app_colors.dart';
import '../../../../global/widgets/shadow_wrapper.dart';

class StatisticsBodyData extends StatelessWidget {
  const StatisticsBodyData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 90),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ShadowWrapper(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 8,
            ),
            child: Column(
              children: const [
                Icon(
                  Icons.boy_rounded,
                  color: AppColors.primaryBold,
                ),
                SizedBox(height: 8),
                Text('150cm'),
                Text('50kg'),
              ],
            ),
          );
        },
      ),
    );
  }
}
