import 'package:flutter/material.dart';

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
    return const AppScaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m, bottom: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: Text('Profil', style: AppTypography.h1),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: ProfileWizardAction(),
            ),
          ),
          SliverPadding(
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
