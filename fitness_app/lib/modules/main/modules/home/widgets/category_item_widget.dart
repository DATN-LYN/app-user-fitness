import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.data.gql.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../../global/themes/app_colors.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  final GCategory category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(CategoryDetailRoute(category: category)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerImage(
            width: 70,
            height: 70,
            borderImage: 1,
            borderRadius: BorderRadius.circular(100),
            imageUrl: category.imgUrl ?? '',
          ),
          const SizedBox(height: 8),
          Text(
            category.name ?? '_',
            style: const TextStyle(
              color: AppColors.grey2,
            ),
          )
        ],
      ),
    );
  }
}
