import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme extension providing semantic colors that adapt to light/dark mode.
/// Access via `Theme.of(context).extension<AppColorsExtension>()` or
/// the shorthand `context.appColors`.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.accent,
    required this.accentDark,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceHighlight,
    required this.textMain,
    required this.textSubtle,
    required this.textInverse,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.border,
    required this.divider,
  });

  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color accent;
  final Color accentDark;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceHighlight;
  final Color textMain;
  final Color textSubtle;
  final Color textInverse;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color border;
  final Color divider;

  static const dark = AppColorsExtension(
    primary: AppColorsDark.primary,
    primaryLight: AppColorsDark.primaryLight,
    primaryDark: AppColorsDark.primaryDark,
    accent: AppColorsDark.accent,
    accentDark: AppColorsDark.accentDark,
    background: AppColorsDark.background,
    surface: AppColorsDark.surface,
    surfaceVariant: AppColorsDark.surfaceVariant,
    surfaceHighlight: AppColorsDark.surfaceHighlight,
    textMain: AppColorsDark.textMain,
    textSubtle: AppColorsDark.textSubtle,
    textInverse: AppColorsDark.textInverse,
    success: AppColorsDark.success,
    warning: AppColorsDark.warning,
    error: AppColorsDark.error,
    info: AppColorsDark.info,
    border: AppColorsDark.border,
    divider: AppColorsDark.divider,
  );

  static const light = AppColorsExtension(
    primary: AppColorsLight.primary,
    primaryLight: AppColorsLight.primaryLight,
    primaryDark: AppColorsLight.primaryDark,
    accent: AppColorsLight.accent,
    accentDark: AppColorsLight.accentDark,
    background: AppColorsLight.background,
    surface: AppColorsLight.surface,
    surfaceVariant: AppColorsLight.surfaceVariant,
    surfaceHighlight: AppColorsLight.surfaceHighlight,
    textMain: AppColorsLight.textMain,
    textSubtle: AppColorsLight.textSubtle,
    textInverse: AppColorsLight.textInverse,
    success: AppColorsLight.success,
    warning: AppColorsLight.warning,
    error: AppColorsLight.error,
    info: AppColorsLight.info,
    border: AppColorsLight.border,
    divider: AppColorsLight.divider,
  );

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
    Color? accent,
    Color? accentDark,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceHighlight,
    Color? textMain,
    Color? textSubtle,
    Color? textInverse,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? border,
    Color? divider,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      accent: accent ?? this.accent,
      accentDark: accentDark ?? this.accentDark,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      textMain: textMain ?? this.textMain,
      textSubtle: textSubtle ?? this.textSubtle,
      textInverse: textInverse ?? this.textInverse,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      border: border ?? this.border,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceHighlight: Color.lerp(surfaceHighlight, other.surfaceHighlight, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

/// Shorthand for accessing theme-aware colors.
extension AppColorsContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
