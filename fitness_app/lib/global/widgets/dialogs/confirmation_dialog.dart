import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../gen/i18n.dart';
import '../../themes/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    this.image,
    this.titleText,
    this.contentText,
    this.title,
    this.content,
    this.positiveButtonText,
    this.onTapPositiveButton,
    this.negativeButtonText,
    this.onTapNegativeButton,
    this.showNegativeButton = true,
  });

  final Widget? image;
  final String? titleText;
  final String? contentText;
  final Widget? title;
  final Widget? content;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onTapPositiveButton;
  final VoidCallback? onTapNegativeButton;
  final bool showNegativeButton;

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                      child: image ??
                          const Icon(
                            Icons.question_answer_outlined,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (titleText != null)
                    Text(
                      titleText!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  else if (title != null)
                    title!,
                  if (content != null)
                    content!
                  else if (contentText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 32),
                      child: Text(
                        contentText!,
                        style: const TextStyle(color: AppColors.grey2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Row(
                    children: [
                      if (showNegativeButton) ...[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onTapNegativeButton ?? context.popRoute,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.grey6,
                            ),
                            child:
                                Text(negativeButtonText ?? i18n.button_Cancel),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onTapPositiveButton ?? context.popRoute,
                          child: Text(positiveButtonText ?? i18n.button_Ok),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showNegativeButton)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: context.popRoute,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.grey2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
