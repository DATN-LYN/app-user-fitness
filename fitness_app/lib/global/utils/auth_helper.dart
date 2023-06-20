import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../gen/i18n.dart';
import '../routers/app_router.dart';
import '../widgets/dialogs/confirmation_dialog.dart';

class AuthHelper {
  AuthHelper._();

  static void showLoginDialog(BuildContext context) {
    final i18n = I18n.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          titleText: i18n.common_Oops,
          contentText: i18n.common_YouHaveToLogin,
          image: const Icon(
            Icons.warning,
            color: AppColors.primaryBold,
          ),
          positiveButtonText: i18n.login_LogIn,
          showNegativeButton: false,
          onTapPositiveButton: () {
            context.popRoute();
            context.pushRoute(const LoginRoute());
          },
        );
      },
    );
  }
}
