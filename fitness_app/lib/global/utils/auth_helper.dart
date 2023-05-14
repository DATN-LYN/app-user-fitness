import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routers/app_router.dart';
import '../widgets/dialogs/confirmation_dialog.dart';

class AuthHelper {
  AuthHelper._();

  static void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          titleText: 'Oops',
          contentText: 'You have to log in to use this feature',
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
