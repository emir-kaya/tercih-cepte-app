import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/featured_university.dart';

class HomeFeaturedUniversities extends StatelessWidget {
  final List<FeaturedUniversity> universities;

  const HomeFeaturedUniversities({
    super.key,
    required this.universities,
  });

  @override
  Widget build(BuildContext context) {
    if (universities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Text('Öne Çıkan Üniversiteler', style: AppTypography.h3),
        ),
        const SizedBox(height: AppSpacing.m),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            scrollDirection: Axis.horizontal,
            itemCount: universities.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.m),
            itemBuilder: (context, index) {
              final item = universities[index];
              return SizedBox(
                width: 280,
                child: AppCard(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.school_outlined, color: AppColors.primary),
                          ),
                          const SizedBox(width: AppSpacing.s),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.city,
                                  style: AppTypography.bodySm.copyWith(color: AppColors.textSubtle),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        item.shortDescription,
                        style: AppTypography.bodySm,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.type,
                            style: AppTypography.label.copyWith(color: AppColors.primary),
                          ),
                          Text(
                            item.scoreRange,
                            style: AppTypography.label,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
