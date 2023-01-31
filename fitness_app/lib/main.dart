import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import 'global/routers/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
        FormBuilderLocalizations.delegate.load(const Locale('en', 'US'));

    //return ();
  }
}
