import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/services/hive_service.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/indicator_loading.dart';
import 'package:fitness_app/locator.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final hiveService = locator.get<HiveService>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (hiveService.getAppSettings().isFirstLaunch) {
          AutoRouter.of(context).replaceAll([
            const OnBoardRoute(),
          ]);
        } else {
          AutoRouter.of(context).replaceAll(
            [const MainRoute()],
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
          child: IndicatorLoading(
        color: AppColors.white,
      )),
    );
  }
}
