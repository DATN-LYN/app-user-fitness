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
      final args = routeData.argsAs<PlayExerciseRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PlayExercisePage(
          key: args.key,
          exercises: args.exercises,
          program: args.program,
        ),
      );
    },
    CountdownTimerRoute.name: (routeData) {
      final args = routeData.argsAs<CountdownTimerRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CountdownTimerPage(
          key: args.key,
          initialDuration: args.initialDuration,
          isBreak: args.isBreak,
          exercises: args.exercises,
          index: args.index,
          program: args.program,
        ),
      );
    },
    FinishRoute.name: (routeData) {
      final args = routeData.argsAs<FinishRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: FinishPage(
          key: args.key,
          exercises: args.exercises,
          program: args.program,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    CategoryListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CategoryListPage(),
      );
    },
    ProgramListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProgramListPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    SupportListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SupportListPage(),
      );
    },
    SupportUpsertRoute.name: (routeData) {
      final args = routeData.argsAs<SupportUpsertRouteArgs>(
          orElse: () => const SupportUpsertRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SupportUpsertPage(
          key: args.key,
          support: args.support,
        ),
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
        RouteConfig(
          CategoryListRoute.name,
          path: '/category-list-page',
        ),
        RouteConfig(
          ProgramListRoute.name,
          path: '/program-list-page',
        ),
        RouteConfig(
          EditProfileRoute.name,
          path: '/edit-profile-page',
        ),
        RouteConfig(
          SupportListRoute.name,
          path: '/support-list-page',
        ),
        RouteConfig(
          SupportUpsertRoute.name,
          path: '/support-upsert-page',
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
class PlayExerciseRoute extends PageRouteInfo<PlayExerciseRouteArgs> {
  PlayExerciseRoute({
    Key? key,
    required List<GExercise> exercises,
    required GProgram program,
  }) : super(
          PlayExerciseRoute.name,
          path: '/play-exercise-page',
          args: PlayExerciseRouteArgs(
            key: key,
            exercises: exercises,
            program: program,
          ),
        );

  static const String name = 'PlayExerciseRoute';
}

class PlayExerciseRouteArgs {
  const PlayExerciseRouteArgs({
    this.key,
    required this.exercises,
    required this.program,
  });

  final Key? key;

  final List<GExercise> exercises;

  final GProgram program;

  @override
  String toString() {
    return 'PlayExerciseRouteArgs{key: $key, exercises: $exercises, program: $program}';
  }
}

/// generated route for
/// [CountdownTimerPage]
class CountdownTimerRoute extends PageRouteInfo<CountdownTimerRouteArgs> {
  CountdownTimerRoute({
    Key? key,
    Duration initialDuration = const Duration(seconds: 3),
    bool isBreak = false,
    required List<GExercise> exercises,
    int? index,
    GProgram? program,
  }) : super(
          CountdownTimerRoute.name,
          path: '/countdown-timer-page',
          args: CountdownTimerRouteArgs(
            key: key,
            initialDuration: initialDuration,
            isBreak: isBreak,
            exercises: exercises,
            index: index,
            program: program,
          ),
        );

  static const String name = 'CountdownTimerRoute';
}

class CountdownTimerRouteArgs {
  const CountdownTimerRouteArgs({
    this.key,
    this.initialDuration = const Duration(seconds: 3),
    this.isBreak = false,
    required this.exercises,
    this.index,
    this.program,
  });

  final Key? key;

  final Duration initialDuration;

  final bool isBreak;

  final List<GExercise> exercises;

  final int? index;

  final GProgram? program;

  @override
  String toString() {
    return 'CountdownTimerRouteArgs{key: $key, initialDuration: $initialDuration, isBreak: $isBreak, exercises: $exercises, index: $index, program: $program}';
  }
}

/// generated route for
/// [FinishPage]
class FinishRoute extends PageRouteInfo<FinishRouteArgs> {
  FinishRoute({
    Key? key,
    required List<GExercise> exercises,
    required GProgram program,
  }) : super(
          FinishRoute.name,
          path: '/finish-page',
          args: FinishRouteArgs(
            key: key,
            exercises: exercises,
            program: program,
          ),
        );

  static const String name = 'FinishRoute';
}

class FinishRouteArgs {
  const FinishRouteArgs({
    this.key,
    required this.exercises,
    required this.program,
  });

  final Key? key;

  final List<GExercise> exercises;

  final GProgram program;

  @override
  String toString() {
    return 'FinishRouteArgs{key: $key, exercises: $exercises, program: $program}';
  }
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
/// [CategoryListPage]
class CategoryListRoute extends PageRouteInfo<void> {
  const CategoryListRoute()
      : super(
          CategoryListRoute.name,
          path: '/category-list-page',
        );

  static const String name = 'CategoryListRoute';
}

/// generated route for
/// [ProgramListPage]
class ProgramListRoute extends PageRouteInfo<void> {
  const ProgramListRoute()
      : super(
          ProgramListRoute.name,
          path: '/program-list-page',
        );

  static const String name = 'ProgramListRoute';
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute()
      : super(
          EditProfileRoute.name,
          path: '/edit-profile-page',
        );

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [SupportListPage]
class SupportListRoute extends PageRouteInfo<void> {
  const SupportListRoute()
      : super(
          SupportListRoute.name,
          path: '/support-list-page',
        );

  static const String name = 'SupportListRoute';
}

/// generated route for
/// [SupportUpsertPage]
class SupportUpsertRoute extends PageRouteInfo<SupportUpsertRouteArgs> {
  SupportUpsertRoute({
    Key? key,
    GSupport? support,
  }) : super(
          SupportUpsertRoute.name,
          path: '/support-upsert-page',
          args: SupportUpsertRouteArgs(
            key: key,
            support: support,
          ),
        );

  static const String name = 'SupportUpsertRoute';
}

class SupportUpsertRouteArgs {
  const SupportUpsertRouteArgs({
    this.key,
    this.support,
  });

  final Key? key;

  final GSupport? support;

  @override
  String toString() {
    return 'SupportUpsertRouteArgs{key: $key, support: $support}';
  }
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
