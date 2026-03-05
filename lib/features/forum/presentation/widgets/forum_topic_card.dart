import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_radius.dart';
import '../../domain/entities/forum_topic.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () {
            context.go('${RoutePaths.forum}/${RoutePaths.forumDetail}', extra: topic);
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: Text(
                        topic.authorName.substring(0, 1).toUpperCase(),
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s),
                    Text(
                      topic.authorName,
                      style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: topic.authorRole == 'Öğrenci' 
                            ? AppColors.success.withValues(alpha: 0.15) 
                            : AppColors.info.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        topic.authorRole,
                        style: AppTypography.caption.copyWith(
                          color: topic.authorRole == 'Öğrenci' ? AppColors.success : AppColors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDate(topic.lastActivityDate),
                      style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.m),
                Text(
                  topic.title,
                  style: AppTypography.h3,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  topic.universityName,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.primaryLight),
                ),
                const SizedBox(height: AppSpacing.m),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: AppSpacing.s,
                        runSpacing: AppSpacing.s,
                        children: topic.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '#$tag',
                              style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.m),
                    Row(
                      children: [
                        Icon(Icons.remove_red_eye_rounded, size: 16, color: AppColors.textSubtle),
                        const SizedBox(width: 4),
                        Text(topic.viewCount.toString(), style: AppTypography.caption.copyWith(color: AppColors.textSubtle)),
                        const SizedBox(width: AppSpacing.m),
                        Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppColors.textSubtle),
                        const SizedBox(width: 4),
                        Text(topic.replyCount.toString(), style: AppTypography.caption.copyWith(color: AppColors.textSubtle)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
