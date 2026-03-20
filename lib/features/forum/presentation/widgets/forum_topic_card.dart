import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/forum_topic.dart';
import '../bloc/forum_bloc.dart';
import '../bloc/forum_event.dart';
import '../utils/forum_role_helper.dart';

class ForumTopicCard extends StatelessWidget {
  final ForumTopic topic;

  const ForumTopicCard({
    super.key,
    required this.topic,
  });

  String _formatDate(BuildContext context, DateTime date) {
    final difference = DateTime.now().difference(date);
    final t = context.l10n;
    if (difference.inMinutes < 60) {
      return t.timeMinutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return t.timeHoursAgo(difference.inHours);
    } else {
      return DateFormat('d MMM', 'tr_TR').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final displayRole = localizeRole(context, topic.authorRole);
    final roleColor = topic.authorRole == 'university' ? colors.success : colors.info;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border, width: 0.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () async {
            await context.push(
              '${RoutePaths.forum}/${RoutePaths.forumDetail}',
              extra: topic,
            );
            if (context.mounted) {
              context.read<ForumBloc>().add(RefreshForumData());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author row
                _buildAuthorRow(context, colors, roleColor, displayRole),
                const SizedBox(height: AppSpacing.s),

                // Title
                Text(
                  topic.title,
                  style: AppTypography.bodyLg.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: colors.textMain,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),

                // University
                Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 14,
                      color: colors.primary.withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        topic.universityName,
                        style: AppTypography.bodySm.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s),

                // Tags + Stats
                _buildFooter(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorRow(BuildContext context, AppColorsExtension colors, Color roleColor, String displayRole) {
    return Row(
      children: [
        // Avatar with gradient border
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [roleColor, roleColor.withValues(alpha: 0.5)],
            ),
          ),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: colors.surfaceVariant,
            child: Text(
              topic.authorName.substring(0, 1).toUpperCase(),
              style: AppTypography.bodySm.copyWith(
                color: colors.textMain,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),

        // Name + role
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.authorName,
                style: AppTypography.bodySm.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.textMain,
                ),
              ),
              Text(
                displayRole,
                style: AppTypography.caption.copyWith(color: roleColor, fontWeight: FontWeight.w500, fontSize: 10),
              ),
            ],
          ),
        ),

        // Date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            _formatDate(context, topic.lastActivityDate),
            style: AppTypography.caption.copyWith(
              color: colors.textSubtle,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(AppColorsExtension colors) {
    return Row(
      children: [
        // Tags (max 2)
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: topic.tags.take(2).map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.15),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  '#$tag',
                  style: AppTypography.caption.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Stats
        _buildStat(Icons.visibility_outlined, topic.viewCount, colors),
        const SizedBox(width: AppSpacing.s),
        _buildStat(Icons.chat_bubble_outline_rounded, topic.replyCount, colors),

        // Bookmark
        const SizedBox(width: AppSpacing.xs),
        Icon(
          topic.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: 18,
          color: topic.isSaved ? colors.warning : colors.textSubtle,
        ),
      ],
    );
  }

  Widget _buildStat(IconData icon, int count, AppColorsExtension colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colors.textSubtle),
        const SizedBox(width: 3),
        Text(
          count.toString(),
          style: AppTypography.caption.copyWith(
            color: colors.textSubtle,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
