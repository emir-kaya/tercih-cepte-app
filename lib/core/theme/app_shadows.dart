import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static final List<BoxShadow> sm = [
    BoxShadow(
      color: AppColors.textMain.withValues(alpha: 0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> md = [
    BoxShadow(
      color: AppColors.textMain.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: AppColors.textMain.withValues(alpha: 0.03),
      blurRadius: 3,
      offset: const Offset(0, -1),
    ),
  ];

  static final List<BoxShadow> lg = [
    BoxShadow(
      color: AppColors.textMain.withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}
