// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettings _$$_AppSettingsFromJson(Map<String, dynamic> json) =>
    _$_AppSettings(
      json['locale'] ?? AppLocale.auto,
      json['theme'] ?? AppTheme.auto,
      json['isFirstLaunch'] as bool? ?? true,
    );

Map<String, dynamic> _$$_AppSettingsToJson(_$_AppSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'theme': instance.theme,
      'isFirstLaunch': instance.isFirstLaunch,
    };
