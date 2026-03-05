import 'package:flutter/material.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/app_text_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Merhaba, Emir 👋', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Bugün hedefine bir adım daha yaklaş.',
                    style: AppTypography.bodyMd.copyWith(color: AppColors.textSubtle),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.surfaceVariant,
                child: Icon(Icons.person_outline, color: AppColors.textMain),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          const AppTextField(
            hintText: 'Üniversite, bölüm, ders ara...',
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSubtle),
          ),
        ],
      ),
    );
  }
}
