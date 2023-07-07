import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import '../global/gen/i18n.dart';
import '../global/providers/app_settings_provider.dart';
import '../global/routers/app_router.dart';
import '../global/themes/app_themes.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    FormBuilderLocalizations.delegate.load(const Locale('vi', 'VN'));

    return MaterialApp.router(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: I18n.delegate.supportedLocales,
      locale: ref.watch(appSettingProvider).locale.toLocale(),
      localeResolutionCallback: I18n.delegate.resolution(
        fallback: const Locale('vi', 'VN'),
      ),
      theme: AppThemes.light(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child ?? const SizedBox(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // ref.read(appSettingProvider.notifier).reset();
        break;
      default:
    }
  }
}
