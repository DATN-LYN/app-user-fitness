import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import '../../modules/intro/onboard_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
        AutoRoute(page: OnBoardPage),

  ],
)
class AppRouter extends _$AppRouter {}
