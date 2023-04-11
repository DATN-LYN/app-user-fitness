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
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProgramDetailPage(),
      );
    },
    TypeDetailRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TypeDetailPage(),
      );
    },
    ExerciseDetailRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ExerciseDetailPage(),
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
          TypeDetailRoute.name,
          path: '/type-detail-page',
        ),
        RouteConfig(
          ExerciseDetailRoute.name,
          path: '/exercise-detail-page',
        ),
        RouteConfig(
          CountdownTimerRoute.name,
          path: '/countdown-timer-page',
        ),
        RouteConfig(
          FinishRoute.name,
          path: '/finish-page',
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
class ProgramDetailRoute extends PageRouteInfo<void> {
  const ProgramDetailRoute()
      : super(
          ProgramDetailRoute.name,
          path: '/program-detail-page',
        );

  static const String name = 'ProgramDetailRoute';
}

/// generated route for
/// [TypeDetailPage]
class TypeDetailRoute extends PageRouteInfo<void> {
  const TypeDetailRoute()
      : super(
          TypeDetailRoute.name,
          path: '/type-detail-page',
        );

  static const String name = 'TypeDetailRoute';
}

/// generated route for
/// [ExerciseDetailPage]
class ExerciseDetailRoute extends PageRouteInfo<void> {
  const ExerciseDetailRoute()
      : super(
          ExerciseDetailRoute.name,
          path: '/exercise-detail-page',
        );

  static const String name = 'ExerciseDetailRoute';
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
