import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/l10n_extension.dart';
import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_toast.dart';
import '../../bloc/detail/forum_detail_bloc.dart';
import '../../bloc/detail/forum_detail_event.dart';

class ForumReplyBottomSheet extends StatefulWidget {
  final String? replyingTo;
  final String topicId;

  const ForumReplyBottomSheet({
    super.key,
    this.replyingTo,
    required this.topicId,
  });

  static Future<void> show(BuildContext context, {String? replyingTo, required String topicId}) {
    final bloc = context.read<ForumDetailBloc>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: ForumReplyBottomSheet(replyingTo: replyingTo, topicId: topicId),
      ),
    );
  }

  @override
  State<ForumReplyBottomSheet> createState() => _ForumReplyBottomSheetState();
}

class _ForumReplyBottomSheetState extends State<ForumReplyBottomSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool get _hasContent => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_hasContent) return;

    context.read<ForumDetailBloc>().add(AddReplyRequested(
      topicId: widget.topicId,
      content: _controller.text.trim(),
    ));

    Navigator.of(context).pop();
    AppToast.show(
      context,
      message: context.l10n.forumReplySent,
      type: AppToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colors = context.appColors;
    final t = context.l10n;

    return Container(
      padding: EdgeInsets.only(
        bottom: bottomInset > 0 ? bottomInset : bottomPadding,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSpacing.s),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.surfaceHighlight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.m),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: Row(
              children: [
                Icon(Icons.reply_rounded, color: colors.primary, size: 20),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  t.forumWriteReply,
                  style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold, color: colors.textMain),
                ),
              ],
            ),
          ),

          // Replying to indicator
          if (widget.replyingTo != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
              child: Row(
                children: [
                  Icon(Icons.subdirectory_arrow_right_rounded,
                      size: 14, color: colors.textSubtle),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      t.forumReplyingTo(widget.replyingTo!),
                      style: AppTypography.caption.copyWith(
                        color: colors.textSubtle,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.s),
          Divider(height: 1, color: colors.divider),
          const SizedBox(height: AppSpacing.s),

          // Text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                maxLength: 1000,
                style: AppTypography.bodyMd.copyWith(color: colors.textMain),
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: t.forumReplyHint,
                  hintStyle: AppTypography.bodyMd.copyWith(
                    color: colors.textSubtle.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          // Bottom actions
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.s,
            ),
            child: Row(
              children: [
                // Character count
                Text(
                  '${_controller.text.length}/1000',
                  style: AppTypography.caption.copyWith(
                    color: colors.textSubtle.withValues(alpha: 0.5),
                  ),
                ),
                const Spacer(),
                // Send button
                GestureDetector(
                  onTap: _hasContent ? _submit : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      gradient: _hasContent
                          ? LinearGradient(
                              colors: [colors.primary, colors.accent],
                            )
                          : null,
                      color: _hasContent ? null : colors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.circular),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.send_rounded,
                          size: 16,
                          color: _hasContent ? Colors.white : colors.textSubtle,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          t.forumSend,
                          style: AppTypography.bodySm.copyWith(
                            color: _hasContent ? Colors.white : colors.textSubtle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
