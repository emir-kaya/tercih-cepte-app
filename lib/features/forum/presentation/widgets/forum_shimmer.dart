import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_shimmer.dart';

class ForumShimmer extends StatelessWidget {
  const ForumShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(width: 150, height: 32),
                      ShimmerContainer(width: 100, height: 36, borderRadius: 100),
                    ]
                  ),
                  SizedBox(height: AppSpacing.m),
                  ShimmerContainer(width: double.infinity, height: 48), // Search bar
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.m).copyWith(bottom: 140),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.m),
                    child: ShimmerContainer(width: double.infinity, height: 160),
                  );
                },
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
