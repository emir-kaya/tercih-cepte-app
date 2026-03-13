import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/onboard_page_data.dart';

class OnboardPageView extends StatelessWidget {
  final OnboardPageData data;

  const OnboardPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Icon in gradient circle
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: data.gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: data.gradientColors.first.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(data.icon, size: 64, color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Title
          Text(
            data.title,
            style: AppTypography.h1.copyWith(fontSize: 28, height: 1.2, color: colors.textMain),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.m),

          // Description
          Text(
            data.description,
            style: AppTypography.bodyLg.copyWith(
              color: colors.textSubtle,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
