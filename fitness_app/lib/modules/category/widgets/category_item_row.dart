import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.data.gql.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../global/routers/app_router.dart';

class CategoryItemRow extends StatelessWidget {
  const CategoryItemRow({
    super.key,
    required this.category,
  });

  final GCategory category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(CategoryDetailRoute(category: category)),
      child: ShadowWrapper(
        child: Row(
          children: [
            ShimmerImage(
              imageUrl: category.imgUrl ?? '_',
              width: 100,
              height: 100,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 16),
            Text(
              category.name ?? '_',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
