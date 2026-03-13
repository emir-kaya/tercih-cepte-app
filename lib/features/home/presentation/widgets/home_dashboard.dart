import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../domain/entities/dashboard_stats.dart';

class HomeDashboard extends StatelessWidget {
  final DashboardStats stats;

  const HomeDashboard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sisteme Bakış', style: AppTypography.h3),
          const SizedBox(height: AppSpacing.m),
          Row(
            children: [
              Expanded(
                child: _DashboardCard(
                  title: 'Üniversite',
                  value: stats.totalUniversities.toString(),
                  icon: Icons.account_balance_rounded,
                  gradientColors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: _DashboardCard(
                  title: 'Bölüm',
                  value: stats.totalDepartments.toString(),
                  icon: Icons.menu_book_rounded,
                  gradientColors: [
                    AppColors.info,
                    const Color(0xFF1D4ED8),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final List<Color> gradientColors;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 28),
          const SizedBox(height: AppSpacing.m),
          Text(
            value,
            style: AppTypography.h2.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: AppTypography.bodySm.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
