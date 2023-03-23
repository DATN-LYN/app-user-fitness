import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'shimmer_image.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.avatar,
    this.fullName,
  }) : super(key: key);
  final String? avatar;
  final String? fullName;

  @override
  Widget build(BuildContext context) {
    return ShimmerImage(
      imageUrl: avatar ?? '',
      height: 40,
      width: 40,
      borderImage: 100,
      errorWidget: Container(
        color: AppColors.grey6,
        alignment: Alignment.center,
        child: Center(
          child: Text(
            fullName?.substring(0, 1).toUpperCase() ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.grey2,
            ),
          ),
        ),
      ),
    );
  }
}
