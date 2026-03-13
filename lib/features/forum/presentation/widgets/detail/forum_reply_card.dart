import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../domain/entities/forum_reply.dart';
import 'forum_reply_bottom_sheet.dart';

class ForumReplyCard extends StatelessWidget {
  final ForumReply reply;

  const ForumReplyCard({
    super.key,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: colors.primary.withValues(alpha: 0.1),
                child: Text(
                  reply.authorName.isNotEmpty ? reply.authorName.substring(0, 1) : '?',
                  style: AppTypography.bodyMd.copyWith(
                    color: colors.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reply.authorName,
                      style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600, color: colors.textMain),
                    ),
                    Text(
                      reply.authorRole,
                      style: AppTypography.caption.copyWith(color: colors.textSubtle),
                    ),
                  ],
                ),
              ),
              Text(
                _formatTimeAgo(reply.createdAt),
                style: AppTypography.caption.copyWith(color: colors.textSubtle),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            reply.content,
            style: AppTypography.bodyMd.copyWith(
              height: 1.5,
              color: colors.textMain.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Row(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        reply.isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
                        size: 16,
                        color: reply.isLiked ? colors.primary : colors.textSubtle,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${reply.likeCount}',
                        style: AppTypography.caption.copyWith(
                          color: reply.isLiked ? colors.primary : colors.textSubtle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.l),
              InkWell(
                onTap: () => ForumReplyBottomSheet.show(
                  context,
                  replyingTo: reply.authorName,
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.reply_rounded,
                        size: 16,
                        color: colors.textSubtle,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Yanıtla',
                        style: AppTypography.caption.copyWith(
                          color: colors.textSubtle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}d';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}s';
    } else {
      return '${difference.inDays}g';
    }
  }
}
