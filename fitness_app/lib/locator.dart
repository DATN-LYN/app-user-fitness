import 'package:cloudinary_dart/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'global/services/hive_service.dart';
import 'global/utils/constants.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  await Hive.initFlutter();
  await Hive.openBox(Constants.hiveDataBox);

  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: 'dltbbrtlv',
  );

  locator.registerLazySingleton<HiveService>(() => HiveServiceImpl());
}
