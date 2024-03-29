import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/modules/forgot_password/forgot_password_page.dart';
import 'package:fitness_app/modules/login/login_page.dart';
import 'package:fitness_app/modules/main/modules/chat/chat_page.dart';
import 'package:fitness_app/modules/main/modules/home/home_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/category/detail/category_detail_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/category/list/category_list_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/exercise/countdown_timer_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/exercise/play_exercise_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/detail/program_detail_page.dart';
import 'package:fitness_app/modules/main/modules/home/modules/program/list/program_list_page.dart';
import 'package:fitness_app/modules/main/modules/settings/setting_page.dart';
import 'package:fitness_app/modules/main/modules/statistics/statistics_page.dart';
import 'package:fitness_app/modules/main/modules/support/support_upsert_page.dart';
import 'package:fitness_app/modules/profile/edit_profile_page.dart';
import 'package:fitness_app/modules/signup/sign_up_page.dart';
import 'package:fitness_app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../../modules/intro/onboard_page.dart';
import '../../modules/main/main_page.dart';
import '../../modules/main/modules/home/modules/exercise/finish_page.dart';
import '../../modules/main/modules/home/modules/search/search_page.dart';
import '../../modules/main/modules/support/support_list_page.dart';
import '../graphql/fragment/__generated__/category_fragment.data.gql.dart';
import '../graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import '../graphql/fragment/__generated__/program_fragment.data.gql.dart';
import '../graphql/fragment/__generated__/support_fragment.data.gql.dart';

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
        AutoRoute(page: ChatPage),
        AutoRoute(page: StatisticsPage),
      ],
    ),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: ForgotPasswordPage),
    AutoRoute(page: ProgramDetailPage),
    AutoRoute(page: CategoryDetailPage),
    AutoRoute(page: PlayExercisePage),
    AutoRoute(page: CountdownTimerPage),
    AutoRoute(page: FinishPage),
    AutoRoute(page: SearchPage),
    AutoRoute(page: CategoryListPage),
    AutoRoute(page: ProgramListPage),
    AutoRoute(page: EditProfilePage),
    AutoRoute(page: SupportListPage),
    AutoRoute(page: SupportUpsertPage),
  ],
)
class AppRouter extends _$AppRouter {}
