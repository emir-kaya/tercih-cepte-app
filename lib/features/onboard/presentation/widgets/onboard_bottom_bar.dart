import 'package:flutter/material.dart';

import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardBottomBar extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onGetStarted;

  const OnboardBottomBar({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
    required this.onGetStarted,
  });

  bool get _isLastPage => currentIndex == totalPages - 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: _isLastPage ? _buildGetStartedButton(context) : _buildNavRow(context),
    );
  }

  Widget _buildNavRow(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onSkip,
          child: Text(
            context.l10n.onboardSkip,
            style: AppTypography.bodyMd.copyWith(
              color: colors.textSubtle,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: onNext,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary, colors.accent],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primaryDark, colors.primary, colors.accent],
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            onTap: onGetStarted,
            child: Center(
              child: Text(
                context.l10n.onboardGetStarted,
                style: AppTypography.bodyLg.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
