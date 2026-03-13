import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/university_detail.dart';

class AcademicStaffSection extends StatelessWidget {
  final AcademicStaff staff;

  const AcademicStaffSection({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    final items = [
      _AcademicItem('Profesör', staff.professor, Icons.star_rounded, const [AppColors.warning, Color(0xFFD97706)]),
      _AcademicItem('Doçent', staff.associateProfessor, Icons.workspace_premium_rounded, const [AppColors.primary, AppColors.primaryDark]),
      _AcademicItem('Doktor', staff.doctor, Icons.school_rounded, const [AppColors.accent, AppColors.accentDark]),
      _AcademicItem('Ar. Gör.', staff.researchAssistant, Icons.science_rounded, const [AppColors.info, Color(0xFF1D4ED8)]),
      _AcademicItem('Öğr. Gör.', staff.lecturer, Icons.record_voice_over_rounded, const [AppColors.success, Color(0xFF16A34A)]),
    ];

    final total = staff.professor + staff.associateProfessor + staff.doctor + staff.researchAssistant + staff.lecturer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Row(
            children: [
              const Text('Akademik Kadro', style: AppTypography.h3),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Toplam $total',
                  style: AppTypography.label.copyWith(color: AppColors.primaryLight),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        SizedBox(
          height: 130,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
            itemBuilder: (context, index) {
              final item = items[index];
              return _AcademicCard(item: item);
            },
          ),
        ),
      ],
    );
  }
}

class _AcademicItem {
  final String title;
  final int count;
  final IconData icon;
  final List<Color> gradient;

  const _AcademicItem(this.title, this.count, this.icon, this.gradient);
}

class _AcademicCard extends StatelessWidget {
  final _AcademicItem item;

  const _AcademicCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: item.gradient.first.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: item.gradient),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 16, color: Colors.white),
          ),
          const Spacer(),
          Text(
            item.count.toString(),
            style: AppTypography.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            item.title,
            style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
          ),
        ],
      ),
    );
  }
}
