import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_radius.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.s),
          child: Text(
            'Uygulama Ayarları',
            style: AppTypography.label,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                title: 'Tema (Koyu Mod)',
                icon: Icons.dark_mode_outlined,
                trailing: Switch(
                  value: true, // Mock value
                  onChanged: (val) {},
                  activeColor: AppColors.primary,
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              _buildSettingItem(
                title: 'Uygulama Dili',
                icon: Icons.language_rounded,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Türkçe', style: AppTypography.bodyMd.copyWith(color: AppColors.textSubtle)),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textSubtle),
                  ],
                ),
                onTap: () {},
              ),
               const Divider(height: 1, color: AppColors.border),
              _buildSettingItem(
                title: 'Bildirimler',
                icon: Icons.notifications_none_rounded,
                trailing: Switch(
                  value: false, // Mock value
                  onChanged: (val) {},
                  activeColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.s),
          child: Text(
            'Hesap',
            style: AppTypography.label,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
               _buildSettingItem(
                title: 'Profilimi Düzenle',
                icon: Icons.person_outline_rounded,
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textSubtle),
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.border),
              _buildSettingItem(
                title: 'Çıkış Yap',
                icon: Icons.logout_rounded,
                titleColor: AppColors.error,
                iconColor: AppColors.error,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.m),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.s),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 20, color: iconColor ?? AppColors.textMain),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyLg.copyWith(
                    fontWeight: FontWeight.w500,
                    color: titleColor ?? AppColors.textMain,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
