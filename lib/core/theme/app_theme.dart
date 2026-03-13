import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_colors_extension.dart';
import 'app_radius.dart';
import 'app_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColorsDark.primary,
        secondary: AppColorsDark.primaryLight,
        surface: AppColorsDark.surface,
        error: AppColorsDark.error,
        onPrimary: AppColorsDark.textInverse,
        onSecondary: AppColorsDark.textInverse,
        onSurface: AppColorsDark.textMain,
        onError: AppColorsDark.textMain,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColorsDark.textMain,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: AppTypography.h1,
        displayMedium: AppTypography.h2,
        displaySmall: AppTypography.h3,
        bodyLarge: AppTypography.bodyLg,
        bodyMedium: AppTypography.bodyMd,
        bodySmall: AppTypography.bodySm,
        labelLarge: AppTypography.label,
        labelSmall: AppTypography.caption,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: AppColorsDark.textMain,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsDark.primaryLight,
          side: const BorderSide(color: AppColorsDark.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColorsDark.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColorsDark.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsDark.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsDark.error),
        ),
        hintStyle: AppTypography.bodyMd.copyWith(color: AppColorsDark.textSubtle),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColorsDark.divider,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extensions: const [AppColorsExtension.dark],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.background,
      colorScheme: const ColorScheme.light(
        primary: AppColorsLight.primary,
        secondary: AppColorsLight.primaryLight,
        surface: AppColorsLight.surface,
        error: AppColorsLight.error,
        onPrimary: AppColorsLight.textInverse,
        onSecondary: AppColorsLight.textInverse,
        onSurface: AppColorsLight.textMain,
        onError: AppColorsLight.textInverse,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColorsLight.textMain,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(color: AppColorsLight.textMain),
        displayMedium: AppTypography.h2.copyWith(color: AppColorsLight.textMain),
        displaySmall: AppTypography.h3.copyWith(color: AppColorsLight.textMain),
        bodyLarge: AppTypography.bodyLg.copyWith(color: AppColorsLight.textMain),
        bodyMedium: AppTypography.bodyMd.copyWith(color: AppColorsLight.textMain),
        bodySmall: AppTypography.bodySm.copyWith(color: AppColorsLight.textMain),
        labelLarge: AppTypography.label.copyWith(color: AppColorsLight.textSubtle),
        labelSmall: AppTypography.caption.copyWith(color: AppColorsLight.textSubtle),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.primary,
          foregroundColor: AppColorsLight.textInverse,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsLight.primary,
          side: const BorderSide(color: AppColorsLight.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColorsLight.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColorsLight.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsLight.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColorsLight.error),
        ),
        hintStyle: AppTypography.bodyMd.copyWith(color: AppColorsLight.textSubtle),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColorsLight.divider,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extensions: const [AppColorsExtension.light],
    );
  }
}
