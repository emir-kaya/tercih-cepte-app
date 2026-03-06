import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: CustomScrollView(
        slivers: [
          // Header Header Placeholders
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.l),
                  ShimmerContainer(width: 200, height: 32),
                  SizedBox(height: AppSpacing.s),
                  ShimmerContainer(width: double.infinity, height: 48, borderRadius: AppRadius.sm), // Search bar
                ],
              ),
            ),
          ),
          
          // Dashboard Placeholder
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.xs),
              child: Column(
                children: [
                   Row(
                    children: [
                       ShimmerContainer(width: 150, height: 24),
                    ],
                  ),
                  SizedBox(height: AppSpacing.s),
                  Row(
                    children: [
                      Expanded(child: ShimmerContainer(height: 120)),
                      SizedBox(width: AppSpacing.m),
                      Expanded(child: ShimmerContainer(height: 120)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Featured Universities Placeholder
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: AppSpacing.m, top: AppSpacing.l),
              child: ShimmerContainer(width: 150, height: 24),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(AppSpacing.m),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: AppSpacing.m),
                    child: ShimmerContainer(width: 140, height: 200),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
