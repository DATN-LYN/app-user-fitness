import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData light() {
    return getThemeData(
      Brightness.light,
      const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        background: AppColors.background,
        onBackground: AppColors.grey1,
      ),
    );
  }

  static ThemeData dark() {
    return getThemeData(
      Brightness.dark,
      const ColorScheme.dark(
        primary: AppColors.primary,
      ),
    );
  }

  static ThemeData getThemeData(
    Brightness brightness,
    ColorScheme colorScheme,
  ) {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      backgroundColor: AppColors.background,
      scaffoldBackgroundColor: AppColors.white,
      indicatorColor: AppColors.primary,
      toggleableActiveColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        foregroundColor: AppColors.grey2,
        iconTheme: IconThemeData(
          color: AppColors.grey1,
        ),
        elevation: 0.3,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.grey1,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: const BoxConstraints(
          minHeight: 40,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.grey4,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey6),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),

    );
  }
}