import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_paths.dart';
import '../../../../../core/locale/l10n_extension.dart';
import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_text_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

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
                  Text(t.homeGreeting('Emir'), style: AppTypography.h3.copyWith(color: colors.textMain)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    t.homeSubtitle,
                    style: AppTypography.bodyMd.copyWith(color: colors.textSubtle),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: colors.surfaceVariant,
                child: Icon(Icons.person_outline, color: colors.textMain),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          GestureDetector(
            onTap: () {
              context.go('${RoutePaths.home}/${RoutePaths.search}');
            },
            child: AbsorbPointer(
              child: AppTextField(
                hintText: t.homeSearchHint,
                prefixIcon: Icon(Icons.search_rounded, color: colors.textSubtle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
