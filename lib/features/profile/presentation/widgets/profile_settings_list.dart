import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injector.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/locale/locale_cubit.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class ProfileSettingsList extends StatefulWidget {
  const ProfileSettingsList({super.key});

  @override
  State<ProfileSettingsList> createState() => _ProfileSettingsListState();
}

class _ProfileSettingsListState extends State<ProfileSettingsList> {
  bool _languageExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.s),
          child: Text(
            t.settingsAppSettings,
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
                title: t.settingsTheme,
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

              // Language setting + expandable picker
              _buildSettingItem(
                context: context,
                title: t.settingsLanguage,
                icon: Icons.language_rounded,
                trailing: BlocBuilder<LocaleCubit, Locale>(
                  builder: (context, locale) {
                    final isTr = locale.languageCode == 'tr';
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isTr ? t.languageTurkish : t.languageEnglish,
                          style: AppTypography.bodyMd.copyWith(color: colors.primary),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        AnimatedRotation(
                          turns: _languageExpanded ? 0.25 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: colors.textSubtle,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                onTap: () => setState(() => _languageExpanded = !_languageExpanded),
              ),

              // Inline language picker
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: _buildLanguagePicker(context),
                crossFadeState: _languageExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
                sizeCurve: Curves.easeInOut,
              ),

              Divider(height: 1, color: colors.border),
              _buildSettingItem(
                context: context,
                title: t.settingsNotifications,
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
            t.settingsAccount,
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
                title: t.settingsEditProfile,
                icon: Icons.person_outline_rounded,
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colors.textSubtle),
                onTap: () {},
              ),
              Divider(height: 1, color: colors.border),
              _buildSettingItem(
                context: context,
                title: t.settingsLogout,
                icon: Icons.logout_rounded,
                titleColor: colors.error,
                iconColor: colors.error,
                onTap: () async {
                  await getIt<AuthRepository>().logout();
                  if (context.mounted) context.go(RoutePaths.auth);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguagePicker(BuildContext context) {
    final colors = context.appColors;
    final localeCubit = context.read<LocaleCubit>();

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isTr = locale.languageCode == 'tr';

        return Container(
          margin: const EdgeInsets.only(
            left: AppSpacing.l,
            right: AppSpacing.l,
            bottom: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            children: [
              _buildLanguageOption(
                context: context,
                title: 'Türkçe',
                subtitle: 'Turkish',
                isSelected: isTr,
                onTap: () {
                  localeCubit.setLocale(const Locale('tr'));
                  setState(() => _languageExpanded = false);
                },
              ),
              Divider(height: 1, indent: AppSpacing.m, endIndent: AppSpacing.m, color: colors.border),
              _buildLanguageOption(
                context: context,
                title: 'English',
                subtitle: 'İngilizce',
                isSelected: !isTr,
                onTap: () {
                  localeCubit.setLocale(const Locale('en'));
                  setState(() => _languageExpanded = false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? colors.primary : colors.textMain,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(color: colors.textSubtle),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded, color: colors.primary, size: 20),
            ],
          ),
        ),
      ),
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
