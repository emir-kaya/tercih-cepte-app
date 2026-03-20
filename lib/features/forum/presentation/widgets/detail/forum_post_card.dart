import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_chip.dart';
import '../../../domain/entities/forum_topic.dart';
import '../../bloc/detail/forum_detail_bloc.dart';
import '../../utils/forum_role_helper.dart';
import '../../bloc/detail/forum_detail_event.dart';
import 'forum_action_buttons.dart';
import 'forum_reply_bottom_sheet.dart';

class ForumPostCard extends StatelessWidget {
  final ForumTopic topic;

  const ForumPostCard({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

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
                backgroundColor: colors.primary.withValues(alpha: 0.2),
                child: Text(
                  topic.authorName.isNotEmpty ? topic.authorName.substring(0, 1) : '?',
                  style: AppTypography.h3.copyWith(color: colors.primary),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.authorName,
                      style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600, color: colors.textMain),
                    ),
                    Text(
                      localizeRole(context, topic.authorRole),
                      style: AppTypography.caption.copyWith(color: colors.textSubtle),
                    ),
                  ],
                ),
              ),
              AppChip(
                label: topic.universityName,
                backgroundColor: colors.primary.withValues(alpha: 0.1),
                textColor: colors.primaryLight,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),

          // Title
          Text(
            topic.title,
            style: AppTypography.h3.copyWith(color: colors.textMain),
          ),
          const SizedBox(height: AppSpacing.s),

          // Content
          Text(
            topic.content,
            style: AppTypography.bodyMd.copyWith(
              height: 1.5,
              color: colors.textMain.withValues(alpha: 0.9),
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
                      backgroundColor: colors.surfaceVariant,
                      textColor: colors.textSubtle,
                    ))
                .toList(),
          ),

          Divider(height: AppSpacing.xl, color: colors.border),

          // Action Buttons
          ForumActionButtons(
            isLiked: topic.isLiked,
            isSaved: topic.isSaved,
            likeCount: topic.likeCount,
            onLikePressed: () {
              context.read<ForumDetailBloc>().add(ToggleTopicLikeRequested(topic.id));
            },
            onReplyPressed: () {
              ForumReplyBottomSheet.show(context, topicId: topic.id);
            },
            onSavePressed: () {
              context.read<ForumDetailBloc>().add(ToggleTopicSaveRequested(topic.id));
            },
            onSharePressed: () {},
          ),
        ],
      ),
    );
  }
}
