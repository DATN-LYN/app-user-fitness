import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'global/services/hive_service.dart';
import 'global/utils/constants.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  await Hive.initFlutter();
  await Hive.openBox(Constants.hiveDataBox);

  locator.registerLazySingleton<HiveService>(() => HiveServiceImpl());
}
