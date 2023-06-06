import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../gen/i18n.dart';
import '../routers/app_router.dart';
import '../themes/app_colors.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return GestureDetector(
      onTap: () => context.pushRoute(const LoginRoute()),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: AppColors.primary,
        child: Row(
          children: [
            const Icon(
              Ionicons.log_in_outline,
              color: AppColors.grey1,
            ),
            const SizedBox(width: 8),
            Text(
              i18n.common_YouHaveToLogin,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
