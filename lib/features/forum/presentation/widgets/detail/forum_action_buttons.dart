import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/theme/app_spacing.dart';

class ForumActionButtons extends StatelessWidget {
  final bool isLiked;
  final bool isSaved;
  final int likeCount;
  final VoidCallback? onLikePressed;
  final VoidCallback? onReplyPressed;
  final VoidCallback? onSavePressed;
  final VoidCallback? onSharePressed;

  const ForumActionButtons({
    super.key,
    this.isLiked = false,
    this.isSaved = false,
    this.likeCount = 0,
    this.onLikePressed,
    this.onReplyPressed,
    this.onSavePressed,
    this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildActionButton(
                icon: isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
                label: likeCount > 0 ? '$likeCount' : 'Beğen',
                color: isLiked ? AppColors.primary : AppColors.textSubtle,
                onTap: onLikePressed,
              ),
              const SizedBox(width: AppSpacing.m),
              _buildActionButton(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Yanıtla',
                color: AppColors.textSubtle,
                onTap: onReplyPressed,
              ),
            ],
          ),
          Row(
            children: [
              _buildActionButton(
                icon: isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: isSaved ? AppColors.primary : AppColors.textSubtle,
                onTap: onSavePressed,
              ),
              const SizedBox(width: AppSpacing.m),
              _buildActionButton(
                icon: Icons.share_rounded,
                color: AppColors.textSubtle,
                onTap: onSharePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            if (label != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTypography.bodySm.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
