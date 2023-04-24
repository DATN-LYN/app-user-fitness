import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/graphql/query/__generated__/query_get_my_inboxes.data.gql.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.item,
    this.loading,
  });

  final GGetMyInboxesData_getMyInboxes_items? item;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSender = item?.isSender == true;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSender) ...[
              const SizedBox(width: 8),
              Assets.images.logoContainer.image(width: 40, height: 40),
            ],
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * 0.75),
              child: ShadowWrapper(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                borderRadius: BorderRadius.circular(8),
                color: isSender ? AppColors.white : AppColors.primarySoft,
                child: loading == true ||
                        item?.message?.isEmpty == true ||
                        item == null
                    ? const SizedBox(
                        height: 20,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulse,
                          colors: [Colors.black],
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        item?.message ?? '_',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
