import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../../modules/intro/onboard_page.dart';
import '../../modules/main/main_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: OnBoardPage),
    AutoRoute(page: MainPage),
  ],
)
class AppRouter extends _$AppRouter {}
