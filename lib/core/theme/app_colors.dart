import 'package:flutter/material.dart';

/// Dark mode color palette
class AppColorsDark {
  AppColorsDark._();

  // Primary — Cyan
  static const Color primary = Color(0xFF06B6D4);
  static const Color primaryLight = Color(0xFF22D3EE);
  static const Color primaryDark = Color(0xFF0891B2);

  // Accent — Teal
  static const Color accent = Color(0xFF14B8A6);
  static const Color accentDark = Color(0xFF0D9488);

  // Surface & Background
  static const Color background = Color(0xFF0C1117);
  static const Color surface = Color(0xFF161D27);
  static const Color surfaceVariant = Color(0xFF222D3A);
  static const Color surfaceHighlight = Color(0xFF2E3B4B);

  // Text
  static const Color textMain = Color(0xFFF1F5F9);
  static const Color textSubtle = Color(0xFF8B99A8);
  static const Color textInverse = Color(0xFF0C1117);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Border & Divider
  static const Color border = Color(0xFF2A3544);
  static const Color divider = Color(0xFF1E2A36);
}

/// Light mode color palette
class AppColorsLight {
  AppColorsLight._();

  // Primary — Cyan
  static const Color primary = Color(0xFF0891B2);
  static const Color primaryLight = Color(0xFF06B6D4);
  static const Color primaryDark = Color(0xFF0E7490);

  // Accent — Teal
  static const Color accent = Color(0xFF0D9488);
  static const Color accentDark = Color(0xFF0F766E);

  // Surface & Background
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color surfaceHighlight = Color(0xFFE2E8F0);

  // Text
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSubtle = Color(0xFF64748B);
  static const Color textInverse = Color(0xFFF8FAFC);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // Border & Divider
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);
}

/// Backward compatibility alias — points to dark palette.
/// Prefer using `context.appColors` for theme-aware access.
typedef AppColors = AppColorsDark;
