import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/providers/app_settings_provider.dart';
import 'package:fitness_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';

import 'global/routers/app_router.dart';
import 'global/themes/app_themes.dart';

void main() async {
  await setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppSettingsProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    FormBuilderLocalizations.delegate.load(const Locale('en', 'US'));

    return Consumer<AppSettingsProvider>(
      builder: (context, provider, child) {
        return MaterialApp.router(
          title: 'My App',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            I18n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: I18n.delegate.supportedLocales,
          locale: provider.localeData,
          localeResolutionCallback: I18n.delegate.resolution(
            fallback: const Locale('en', 'US'),
          ),
          theme: AppThemes.light(),
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
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
        context.read<AppSettingsProvider>().fetch();
        break;
      default:
    }
  }
}
