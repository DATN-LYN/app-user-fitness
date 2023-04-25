import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../enums/app_locale.dart';
import '../../enums/app_theme.dart';
import '../../utils/constants.dart';
import '../models/app_settings.dart';
import '../models/failure.dart';
import '_base_repository.dart';

final appSettingsRepositoryProvider = Provider((ref) {
  return _AppSettingRepositoryImpl(
    Hive.box(Constants.hiveDataBox),
  );
});

abstract class AppSettingsRepository {
  Either<Failure, AppSettings> getAppSettings();

  Future<Either<Failure, AppSettings>> saveTheme(AppTheme appTheme);

  Future<Either<Failure, AppSettings>> saveLocale(AppLocale appLocale);

  Future<Either<Failure, AppSettings>> saveFirstLaunch([bool value = false]);

  Future<Either<Failure, AppSettings>> resetAppSettings();
}

class _AppSettingRepositoryImpl extends BaseRepository
    implements AppSettingsRepository {
  _AppSettingRepositoryImpl(this.box);

  final Box<String> box;
  final String key = Constants.hiveAppSettingsKey;

  @override
  Either<Failure, AppSettings> getAppSettings() {
    return guard(() {
      final savedAppSettings = box.get(key);
      if (savedAppSettings != null) {
        return AppSettings.fromJson(jsonDecode(savedAppSettings));
      }
      return const AppSettings();
    });
  }

  @override
  Future<Either<Failure, AppSettings>> resetAppSettings() {
    return guardFuture(() async {
      const defaultData = AppSettings();
      await box.put(
        key,
        jsonEncode(defaultData),
      );
      return defaultData;
    });
  }

  @override
  Future<Either<Failure, AppSettings>> saveFirstLaunch([bool value = false]) {
    return guardFuture(() async {
      return getAppSettings().fold(
        (l) => throw l,
        (r) async {
          await box.put(
            key,
            jsonEncode(
              r.copyWith(isFirstLaunch: value).toJson(),
            ),
          );
          return r;
        },
      );
    });
  }

  @override
  Future<Either<Failure, AppSettings>> saveLocale(AppLocale appLocale) {
    return guardFuture(() async {
      return getAppSettings().fold(
        (l) => throw l,
        (r) async {
          await box.put(
            key,
            jsonEncode(
              r.copyWith(locale: appLocale).toJson(),
            ),
          );
          return r;
        },
      );
    });
  }

  @override
  Future<Either<Failure, AppSettings>> saveTheme(AppTheme appTheme) {
    return guardFuture(() async {
      return getAppSettings().fold(
        (l) => throw l,
        (r) async {
          await box.put(
            key,
            jsonEncode(
              r.copyWith(theme: appTheme).toJson(),
            ),
          );
          return r;
        },
      );
    });
  }
}
