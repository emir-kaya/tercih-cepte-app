import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_paths.dart';
import '../../../../../core/locale/l10n_extension.dart';
import '../../../../../core/theme/app_colors_extension.dart';
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

    final colors = context.appColors;
    final t = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Text(t.homeFeaturedUniversities, style: AppTypography.h3.copyWith(color: colors.textMain)),
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
                  onTap: () {
                    context.go(
                      '${RoutePaths.home}/${RoutePaths.universityDetail}',
                      extra: {'id': item.id, 'name': item.name},
                    );
                  },
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
                              color: colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.school_outlined, color: colors.primary),
                          ),
                          const SizedBox(width: AppSpacing.s),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold, color: colors.textMain),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.city,
                                  style: AppTypography.bodySm.copyWith(color: colors.textSubtle),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        item.shortDescription,
                        style: AppTypography.bodySm.copyWith(color: colors.textMain),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.type,
                            style: AppTypography.label.copyWith(color: colors.primary),
                          ),
                          Text(
                            item.scoreRange,
                            style: AppTypography.label.copyWith(color: colors.textSubtle),
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
