import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_settings_list.dart';
import '../widgets/profile_wizard_action.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AppScaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m, bottom: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: Text('Profil', style: AppTypography.h1.copyWith(color: colors.textMain)),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: ProfileWizardAction(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m, bottom: 120), // Bottom padding for Nav Bar
            sliver: SliverToBoxAdapter(
              child: ProfileSettingsList(),
            ),
          ),
        ],
      ),
    );
  }
}
