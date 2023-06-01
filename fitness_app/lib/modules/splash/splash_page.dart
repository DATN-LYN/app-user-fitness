import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:fitness_app/global/providers/app_settings_provider.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/providers/me_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        bool isLogedIn = ref.watch(isSignedInProvider);
        final appSettings = ref.read(appSettingProvider);

        if (appSettings.isFirstLaunch) {
          AutoRouter.of(context).replaceAll([const OnBoardRoute()]);
        } else {
          AutoRouter.of(context).replaceAll([const MainRoute()]);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySoft,
      body: Center(
        child: Assets.images.weight.image(width: 130, height: 130),
      ),
    );
  }
}
