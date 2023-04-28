import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'global/utils/constants.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(Constants.hiveDataBox);
  await Hive.openBox(Constants.hiveGraphqlBox);
  OpenAI.apiKey = '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';
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
