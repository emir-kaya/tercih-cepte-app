import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_shimmer.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return AppShimmer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero shimmer
            Container(
              padding: EdgeInsets.fromLTRB(AppSpacing.m, topPadding + AppSpacing.m, AppSpacing.m, AppSpacing.l),
              decoration: const BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(width: 40, height: 40, borderRadius: 12),
                  SizedBox(height: AppSpacing.l),
                  ShimmerContainer(width: 56, height: 56, borderRadius: 16),
                  SizedBox(height: AppSpacing.m),
                  ShimmerContainer(width: 220, height: 28),
                  SizedBox(height: AppSpacing.xs),
                  ShimmerContainer(width: 160, height: 20),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            // Stats shimmer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Row(
                children: [
                  Expanded(child: ShimmerContainer(height: 72)),
                  SizedBox(width: AppSpacing.s),
                  Expanded(child: ShimmerContainer(height: 72)),
                  SizedBox(width: AppSpacing.s),
                  Expanded(child: ShimmerContainer(height: 72)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            // Contact shimmer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerContainer(width: 100, height: 22),
                  const SizedBox(height: AppSpacing.s),
                  ...List.generate(
                    4,
                    (_) => const Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.s),
                      child: ShimmerContainer(width: double.infinity, height: 52),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            // Academic shimmer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: ShimmerContainer(width: 160, height: 22),
            ),
            const SizedBox(height: AppSpacing.s),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                itemCount: 4,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
                itemBuilder: (_, _) => const ShimmerContainer(width: 120, height: 130),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
