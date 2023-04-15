import 'package:flutter/material.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.isSender,
    required this.content,
    this.contentLoading,
  });

  final bool isSender;
  final String content;
  final Widget? contentLoading;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                child: contentLoading ??
                    Text(
                      content,
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
