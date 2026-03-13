import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/forum_topic.dart';

class ForumTopicCard extends StatelessWidget {
  final ForumTopic topic;

  const ForumTopicCard({
    super.key,
    required this.topic,
  });

  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}d önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}sa önce';
    } else {
      return DateFormat('d MMM', 'tr_TR').format(date);
    }
  }

  Color get _roleColor =>
      topic.authorRole == 'Öğrenci' ? AppColors.success : AppColors.info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () {
            context.go(
              '${RoutePaths.forum}/${RoutePaths.forumDetail}',
              extra: topic,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author row
                _buildAuthorRow(),
                const SizedBox(height: AppSpacing.s),

                // Title
                Text(
                  topic.title,
                  style: AppTypography.bodyLg.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
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
                      color: AppColors.primary.withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        topic.universityName,
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.primary,
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
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorRow() {
    return Row(
      children: [
        // Avatar with gradient border
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [_roleColor, _roleColor.withValues(alpha: 0.5)],
            ),
          ),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.surfaceVariant,
            child: Text(
              topic.authorName.substring(0, 1).toUpperCase(),
              style: AppTypography.bodySm.copyWith(
                color: AppColors.textMain,
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
                ),
              ),
              Text(
                topic.authorRole,
                style: AppTypography.caption.copyWith(
                  color: _roleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),

        // Date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            _formatDate(topic.lastActivityDate),
            style: AppTypography.caption.copyWith(
              color: AppColors.textSubtle,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
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
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  '#$tag',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Stats
        _buildStat(Icons.visibility_outlined, topic.viewCount),
        const SizedBox(width: AppSpacing.s),
        _buildStat(Icons.chat_bubble_outline_rounded, topic.replyCount),

        // Bookmark
        const SizedBox(width: AppSpacing.xs),
        Icon(
          topic.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: 18,
          color: topic.isSaved ? AppColors.warning : AppColors.textSubtle,
        ),
      ],
    );
  }

  Widget _buildStat(IconData icon, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSubtle),
        const SizedBox(width: 3),
        Text(
          count.toString(),
          style: AppTypography.caption.copyWith(
            color: AppColors.textSubtle,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
