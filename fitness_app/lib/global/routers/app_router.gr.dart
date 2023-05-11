// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    OnBoardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const OnBoardPage(),
      );
    },
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    ProgramDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProgramDetailRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ProgramDetailPage(
          key: args.key,
          program: args.program,
        ),
      );
    },
    CategoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryDetailRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CategoryDetailPage(
          category: args.category,
          key: args.key,
        ),
      );
    },
    PlayExerciseRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PlayExercisePage(),
      );
    },
    CountdownTimerRoute.name: (routeData) {
      final args = routeData.argsAs<CountdownTimerRouteArgs>(
          orElse: () => const CountdownTimerRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CountdownTimerPage(
          key: args.key,
          initialDuration: args.initialDuration,
          isBreak: args.isBreak,
          exerciseCount: args.exerciseCount,
        ),
      );
    },
    FinishRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const FinishPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingPage(),
      );
    },
    ChatRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ChatPage(),
      );
    },
    StatisticsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const StatisticsPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        RouteConfig(
          OnBoardRoute.name,
          path: '/on-board-page',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main-page',
          children: [
            RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: MainRoute.name,
            ),
            RouteConfig(
              SettingRoute.name,
              path: 'setting-page',
              parent: MainRoute.name,
            ),
            RouteConfig(
              ChatRoute.name,
              path: 'chat-page',
              parent: MainRoute.name,
            ),
            RouteConfig(
              StatisticsRoute.name,
              path: 'statistics-page',
              parent: MainRoute.name,
            ),
          ],
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-page',
        ),
        RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        ),
        RouteConfig(
          ProgramDetailRoute.name,
          path: '/program-detail-page',
        ),
        RouteConfig(
          CategoryDetailRoute.name,
          path: '/category-detail-page',
        ),
        RouteConfig(
          PlayExerciseRoute.name,
          path: '/play-exercise-page',
        ),
        RouteConfig(
          CountdownTimerRoute.name,
          path: '/countdown-timer-page',
        ),
        RouteConfig(
          FinishRoute.name,
          path: '/finish-page',
        ),
        RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [OnBoardPage]
class OnBoardRoute extends PageRouteInfo<void> {
  const OnBoardRoute()
      : super(
          OnBoardRoute.name,
          path: '/on-board-page',
        );

  static const String name = 'OnBoardRoute';
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main-page',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [ProgramDetailPage]
class ProgramDetailRoute extends PageRouteInfo<ProgramDetailRouteArgs> {
  ProgramDetailRoute({
    Key? key,
    required GProgram program,
  }) : super(
          ProgramDetailRoute.name,
          path: '/program-detail-page',
          args: ProgramDetailRouteArgs(
            key: key,
            program: program,
          ),
        );

  static const String name = 'ProgramDetailRoute';
}

class ProgramDetailRouteArgs {
  const ProgramDetailRouteArgs({
    this.key,
    required this.program,
  });

  final Key? key;

  final GProgram program;

  @override
  String toString() {
    return 'ProgramDetailRouteArgs{key: $key, program: $program}';
  }
}

/// generated route for
/// [CategoryDetailPage]
class CategoryDetailRoute extends PageRouteInfo<CategoryDetailRouteArgs> {
  CategoryDetailRoute({
    required GCategory category,
    Key? key,
  }) : super(
          CategoryDetailRoute.name,
          path: '/category-detail-page',
          args: CategoryDetailRouteArgs(
            category: category,
            key: key,
          ),
        );

  static const String name = 'CategoryDetailRoute';
}

class CategoryDetailRouteArgs {
  const CategoryDetailRouteArgs({
    required this.category,
    this.key,
  });

  final GCategory category;

  final Key? key;

  @override
  String toString() {
    return 'CategoryDetailRouteArgs{category: $category, key: $key}';
  }
}

/// generated route for
/// [PlayExercisePage]
class PlayExerciseRoute extends PageRouteInfo<void> {
  const PlayExerciseRoute()
      : super(
          PlayExerciseRoute.name,
          path: '/play-exercise-page',
        );

  static const String name = 'PlayExerciseRoute';
}

/// generated route for
/// [CountdownTimerPage]
class CountdownTimerRoute extends PageRouteInfo<CountdownTimerRouteArgs> {
  CountdownTimerRoute({
    Key? key,
    Duration initialDuration = const Duration(seconds: 3),
    bool isBreak = false,
    String? exerciseCount,
  }) : super(
          CountdownTimerRoute.name,
          path: '/countdown-timer-page',
          args: CountdownTimerRouteArgs(
            key: key,
            initialDuration: initialDuration,
            isBreak: isBreak,
            exerciseCount: exerciseCount,
          ),
        );

  static const String name = 'CountdownTimerRoute';
}

class CountdownTimerRouteArgs {
  const CountdownTimerRouteArgs({
    this.key,
    this.initialDuration = const Duration(seconds: 3),
    this.isBreak = false,
    this.exerciseCount,
  });

  final Key? key;

  final Duration initialDuration;

  final bool isBreak;

  final String? exerciseCount;

  @override
  String toString() {
    return 'CountdownTimerRouteArgs{key: $key, initialDuration: $initialDuration, isBreak: $isBreak, exerciseCount: $exerciseCount}';
  }
}

/// generated route for
/// [FinishPage]
class FinishRoute extends PageRouteInfo<void> {
  const FinishRoute()
      : super(
          FinishRoute.name,
          path: '/finish-page',
        );

  static const String name = 'FinishRoute';
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search-page',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute()
      : super(
          SettingRoute.name,
          path: 'setting-page',
        );

  static const String name = 'SettingRoute';
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute()
      : super(
          ChatRoute.name,
          path: 'chat-page',
        );

  static const String name = 'ChatRoute';
}

/// generated route for
/// [StatisticsPage]
class StatisticsRoute extends PageRouteInfo<void> {
  const StatisticsRoute()
      : super(
          StatisticsRoute.name,
          path: 'statistics-page',
        );

  static const String name = 'StatisticsRoute';
}
