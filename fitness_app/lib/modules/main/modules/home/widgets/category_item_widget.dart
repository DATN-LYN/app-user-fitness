import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../../global/graphql/query/__generated__/query_get_categories.data.gql.dart';
import '../../../../../global/themes/app_colors.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  final GGetCateforiesData_getCategories_items category;

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const CategoryDetailRoute()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerImage(
            width: 70,
            height: 70,
            borderImage: 1,
            borderRadius: BorderRadius.circular(100),
            imageUrl: widget.category.imgUrl ?? '',
          ),
          const SizedBox(height: 8),
          Text(
            widget.category.name ?? '_',
            style: const TextStyle(
              color: AppColors.grey2,
            ),
          )
        ],
      ),
    );
  }
}
