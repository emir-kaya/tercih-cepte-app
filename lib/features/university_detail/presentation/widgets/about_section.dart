import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/university_detail.dart';

class AboutSection extends StatelessWidget {
  final UniversityDetail detail;

  const AboutSection({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hakkında', style: AppTypography.h3),
        const SizedBox(height: AppSpacing.s),
        Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.accent.withValues(alpha: 0.15),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: AppColors.primaryLight, size: 24),
              ),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rektör',
                      style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail.rector,
                      style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Row(
          children: [
            Expanded(
              child: _AboutTile(
                icon: Icons.domain_rounded,
                label: 'Fakülte / MYO',
                value: detail.facultyCount,
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              child: _AboutTile(
                icon: Icons.menu_book_rounded,
                label: 'Bölüm / Program',
                value: detail.departmentCount,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AboutTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _AboutTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primaryLight),
          const SizedBox(height: AppSpacing.s),
          Text(
            value,
            style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
          ),
        ],
      ),
    );
  }
}
