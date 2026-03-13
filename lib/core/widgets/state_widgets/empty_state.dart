import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.textSubtle.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              title,
              style: AppTypography.h3,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.s),
              Text(
                message!,
                style: AppTypography.bodyMd.copyWith(color: AppColors.textSubtle),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
