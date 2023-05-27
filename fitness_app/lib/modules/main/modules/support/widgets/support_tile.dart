import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/enums/support_status.dart';
import '../../../../../global/gen/i18n.dart';
import '../../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../../global/graphql/cache_handler/upsert_support_cache_handler.dart';
import '../../../../../global/graphql/client.dart';
import '../../../../../global/graphql/fragment/__generated__/support_fragment.data.gql.dart';
import '../../../../../global/graphql/mutation/__generated__/mutation_upsert_support.req.gql.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/shimmer_image.dart';
import '../../../../../global/widgets/tag.dart';

class SupportTile extends ConsumerWidget {
  const SupportTile({
    super.key,
    required this.support,
  });

  final GSupport support;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = SupportStatus.getStatus(support.status ?? 1);
    final i18n = I18n.of(context)!;

    void markRead() async {
      final client = ref.watch(appClientProvider);

      var formData = GUpsertSupportInputDto(
        (b) => b
          ..content = support.content
          ..id = support.id
          ..imgUrl = support.imgUrl
          ..isRead = true
          ..status = support.status
          ..userId = support.userId,
      );
      var request = GUpsertSupportReq(
        (b) => b
          ..vars.input.replace(formData)
          ..updateCacheHandlerKey = UpsertSupportCacheHandler.key
          ..updateCacheHandlerContext = {
            'upsertData': formData,
          },
      );

      await client.request(request).first;
    }

    return InkWell(
      onTap: () {
        markRead();
        // context.pushRoute(SupportUpsertRoute(support: support));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        color: support.isRead == true
            ? Colors.white
            : AppColors.warningSoft.withOpacity(0.7),
        child: Row(
          children: [
            ShimmerImage(
              imageUrl: support.user?.avatar ?? '_',
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    support.user?.email ?? '_',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    support.content ?? '_',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Tag(
              text: status.label(i18n),
              color: status.color(),
            )
          ],
        ),
      ),
    );
  }
}
