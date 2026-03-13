import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/university_detail.dart';

class ContactSection extends StatelessWidget {
  final UniversityDetail detail;

  const ContactSection({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('İletişim', style: AppTypography.h3.copyWith(color: colors.textMain)),
        const SizedBox(height: AppSpacing.s),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(
            children: [
              _ContactTile(
                icon: Icons.language_rounded,
                label: 'Web Sitesi',
                value: detail.website,
              ),
              Divider(height: 1, indent: 56, color: colors.divider),
              _ContactTile(
                icon: Icons.alternate_email_rounded,
                label: 'E-posta',
                value: detail.email,
              ),
              Divider(height: 1, indent: 56, color: colors.divider),
              _ContactTile(
                icon: Icons.phone_rounded,
                label: 'Telefon',
                value: detail.phone,
              ),
              Divider(height: 1, indent: 56, color: colors.divider),
              _ContactTile(
                icon: Icons.map_rounded,
                label: 'Adres',
                value: detail.address,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: colors.primaryLight),
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.caption.copyWith(color: colors.textSubtle),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w500, color: colors.textMain),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, size: 18, color: colors.textSubtle),
        ],
      ),
    );
  }
}
