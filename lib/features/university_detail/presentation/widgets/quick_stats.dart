import 'package:flutter/material.dart';

import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/university_detail.dart';

class QuickStats extends StatelessWidget {
  final UniversityDetail detail;

  const QuickStats({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: t.universityFaculty,
            value: detail.facultyCount.replaceAll(RegExp(r'[^0-9]'), ''),
            gradient: [colors.primary, colors.primaryDark],
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: _StatCard(
            label: t.universityDepartment,
            value: detail.departmentCount.replaceAll(RegExp(r'[^0-9]'), ''),
            gradient: [colors.info, const Color(0xFF1D4ED8)],
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: _StatCard(
            label: t.universityEstablished,
            value: detail.foundedYear.toString(),
            gradient: [colors.accent, colors.accentDark],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final List<Color> gradient;

  const _StatCard({
    required this.label,
    required this.value,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.m, horizontal: AppSpacing.s),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.h2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
