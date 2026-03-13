import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/university_detail.dart';

class AboutSection extends StatelessWidget {
  final UniversityDetail detail;

  const AboutSection({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hakkında', style: AppTypography.h3.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.s),
        Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: colors.surface,
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
                      colors.primary.withValues(alpha: 0.2),
                      colors.accent.withValues(alpha: 0.15),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_rounded, color: colors.primaryLight, size: 24),
              ),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rektör',
                      style: AppTypography.caption.copyWith(color: colors.textSubtle),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail.rector,
                      style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600, color: colors.textMain),
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
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colors.primaryLight),
          const SizedBox(height: AppSpacing.s),
          Text(
            value,
            style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold, color: colors.textMain),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(color: colors.textSubtle),
          ),
        ],
      ),
    );
  }
}
