import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_shimmer.dart';

class ForumShimmer extends StatelessWidget {
  const ForumShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author row
                  const Row(
                    children: [
                      ShimmerContainer(width: 32, height: 32, borderRadius: 16),
                      SizedBox(width: AppSpacing.xs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerContainer(width: 100, height: 12),
                          SizedBox(height: 4),
                          ShimmerContainer(width: 50, height: 10),
                        ],
                      ),
                      Spacer(),
                      ShimmerContainer(width: 55, height: 18, borderRadius: 6),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s),

                  // Title
                  ShimmerContainer(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 16,
                  ),
                  const SizedBox(height: 6),
                  const ShimmerContainer(width: 160, height: 16),
                  const SizedBox(height: AppSpacing.xs),

                  // University
                  const ShimmerContainer(width: 140, height: 12),
                  const SizedBox(height: AppSpacing.s),

                  // Footer
                  const Row(
                    children: [
                      ShimmerContainer(width: 60, height: 20, borderRadius: 6),
                      SizedBox(width: 6),
                      ShimmerContainer(width: 70, height: 20, borderRadius: 6),
                      Spacer(),
                      ShimmerContainer(width: 35, height: 14),
                      SizedBox(width: AppSpacing.s),
                      ShimmerContainer(width: 35, height: 14),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
