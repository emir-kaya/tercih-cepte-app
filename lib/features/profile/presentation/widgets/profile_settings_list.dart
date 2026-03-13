import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_cubit.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.s),
          child: Text(
            'Uygulama Ayarları',
            style: AppTypography.label.copyWith(color: colors.textSubtle),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                context: context,
                title: 'Tema',
                icon: context.read<ThemeCubit>().isDark
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, mode) {
                    return Switch(
                      value: mode == ThemeMode.dark,
                      onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                      activeThumbColor: colors.primary,
                    );
                  },
                ),
              ),
              Divider(height: 1, color: colors.border),
              _buildSettingItem(
                context: context,
                title: 'Uygulama Dili',
                icon: Icons.language_rounded,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Türkçe', style: AppTypography.bodyMd.copyWith(color: colors.textSubtle)),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colors.textSubtle),
                  ],
                ),
                onTap: () {},
              ),
              Divider(height: 1, color: colors.border),
              _buildSettingItem(
                context: context,
                title: 'Bildirimler',
                icon: Icons.notifications_none_rounded,
                trailing: Switch(
                  value: false,
                  onChanged: (val) {},
                  activeThumbColor: colors.primary,
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
            style: AppTypography.label.copyWith(color: colors.textSubtle),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                context: context,
                title: 'Profilimi Düzenle',
                icon: Icons.person_outline_rounded,
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colors.textSubtle),
                onTap: () {},
              ),
              Divider(height: 1, color: colors.border),
              _buildSettingItem(
                context: context,
                title: 'Çıkış Yap',
                icon: Icons.logout_rounded,
                titleColor: colors.error,
                iconColor: colors.error,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    final colors = context.appColors;

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
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 20, color: iconColor ?? colors.textMain),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyLg.copyWith(
                    fontWeight: FontWeight.w500,
                    color: titleColor ?? colors.textMain,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
