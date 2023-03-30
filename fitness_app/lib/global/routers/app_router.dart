import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/widgets/countdown_timer_page.dart';
import 'package:fitness_app/modules/forgot_password/forgot_password_page.dart';
import 'package:fitness_app/modules/login/login_page.dart';
import 'package:fitness_app/modules/main/modules/exercise/exercise_detail_page.dart';
import 'package:fitness_app/modules/main/modules/home/home_page.dart';
import 'package:fitness_app/modules/main/modules/program/program_detail_page.dart';
import 'package:fitness_app/modules/main/modules/settings/setting_page.dart';
import 'package:fitness_app/modules/main/modules/social/social_page.dart';
import 'package:fitness_app/modules/main/modules/type/type_detail_page.dart';
import 'package:fitness_app/modules/signup/sign_up_page.dart';
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
    AutoRoute(
      page: MainPage,
      children: [
        AutoRoute(
          page: HomePage,
          children: [],
        ),
        AutoRoute(page: SettingPage),
        AutoRoute(page: SocialPage),
      ],
    ),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: ForgotPasswordPage),
    AutoRoute(page: ProgramDetailPage),
    AutoRoute(page: TypeDetailPage),
    AutoRoute(page: ExerciseDetailPage),
    AutoRoute(page: CountdownTimerPage),
  ],
)
class AppRouter extends _$AppRouter {}
