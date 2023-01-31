import 'package:fitness_app/global/models/hive/app_settings.dart';
import 'package:hive/hive.dart';

import '../enums/app_locale.dart';
import '../enums/app_theme.dart';
import '../utils/constants.dart';

abstract class HiveService{
  AppSettings getAppSettings();
  Future<void> saveTheme(AppTheme appTheme);
  Future<void> saveLocale(AppLocale appLocale);
  Future<void> saveFirstLaunch([bool value = false]);
  Future<AppSettings> resetAppSettings();
}

class HiveServiceImpl extends HiveService{

    final _box = Hive.box(Constants.hiveDataBox);

  @override
  AppSettings getAppSettings() {
  final savedAppSettings = _box.get(Constants.hiveAppSettingsKey) as String?;
    if (savedAppSettings != null) {
      //return AppSettings.fromJson(jsonDecode(savedAppSettings));
    }
    return const AppSettings();
  }

  @override
  Future<AppSettings> resetAppSettings() {
    // TODO: implement resetAppSettings
    throw UnimplementedError();
  }

  @override
  Future<void> saveFirstLaunch([bool value = false]) {
    // TODO: implement saveFirstLaunch
    throw UnimplementedError();
  }

  @override
  Future<void> saveLocale(AppLocale appLocale) {
    // TODO: implement saveLocale
    throw UnimplementedError();
  }

  @override
  Future<void> saveTheme(AppTheme appTheme) {
    // TODO: implement saveTheme
    throw UnimplementedError();
  }

}