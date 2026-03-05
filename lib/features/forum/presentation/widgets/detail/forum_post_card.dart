import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_chip.dart';
import '../../../domain/entities/forum_topic.dart';
import 'forum_action_buttons.dart';

class ForumPostCard extends StatelessWidget {
  final ForumTopic topic;

  const ForumPostCard({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                child: Text(
                  topic.authorName.isNotEmpty ? topic.authorName.substring(0, 1) : '?',
                  style: AppTypography.h3.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.authorName,
                      style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      topic.authorRole,
                      style: AppTypography.caption.copyWith(color: AppColors.textSubtle),
                    ),
                  ],
                ),
              ),
              AppChip(
                label: topic.universityName,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                textColor: AppColors.primaryLight,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          
          // Title
          Text(
            topic.title,
            style: AppTypography.h3,
          ),
          const SizedBox(height: AppSpacing.s),
          
          // Content
          Text(
            topic.content,
            style: AppTypography.bodyMd.copyWith(
              height: 1.5,
              color: AppColors.textMain.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          
          // Tags
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: topic.tags
                .map((tag) => AppChip(
                      label: tag,
                      backgroundColor: AppColors.surfaceVariant,
                      textColor: AppColors.textSubtle,
                    ))
                .toList(),
          ),
          
          const Divider(height: AppSpacing.xl, color: AppColors.border),
          
          // Action Buttons
          ForumActionButtons(
            isLiked: topic.isLiked,
            isSaved: topic.isSaved,
            likeCount: 42, // Mocking a like count based on views
            onLikePressed: () {},
            onReplyPressed: () {},
            onSavePressed: () {},
            onSharePressed: () {},
          ),
        ],
      ),
    );
  }
}
