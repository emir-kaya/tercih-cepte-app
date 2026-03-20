import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/di/injector.dart';
import '../../../../../core/locale/l10n_extension.dart';
import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_toast.dart';
import '../../../domain/repositories/forum_repository.dart';

class ForumCreateTopicPage extends StatefulWidget {
  const ForumCreateTopicPage({super.key});

  @override
  State<ForumCreateTopicPage> createState() => _ForumCreateTopicPageState();
}

class _ForumCreateTopicPageState extends State<ForumCreateTopicPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();
  String? _selectedUniversity;
  final List<String> _tags = [];

  static const _universities = [
    'Boğaziçi Üniversitesi',
    'ODTÜ',
    'İTÜ',
    'Koç Üniversitesi',
    'Bilkent Üniversitesi',
    'Sabancı Üniversitesi',
    'Hacettepe Üniversitesi',
    'Ankara Üniversitesi',
    'Ege Üniversitesi',
    'Dokuz Eylül Üniversitesi',
  ];

  bool get _isFormValid =>
      _titleController.text.trim().isNotEmpty &&
      _contentController.text.trim().isNotEmpty &&
      _selectedUniversity != null;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag) && _tags.length < 5) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() => _tags.remove(tag));
  }

  bool _isSubmitting = false;

  Future<void> _submitTopic() async {
    if (!_isFormValid || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    final repository = getIt<ForumRepository>();
    final result = await repository.createTopic(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      universityName: _selectedUniversity!,
      tags: _tags,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isSubmitting = false);
        AppToast.show(
          context,
          message: failure.message,
          type: AppToastType.error,
        );
      },
      (_) {
        context.pop(true);
        AppToast.show(
          context,
          message: 'Konu başarıyla oluşturuldu!',
          type: AppToastType.success,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final colors = context.appColors;
    final t = context.l10n;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: colors.textMain),
          onPressed: () => context.pop(),
        ),
        title: Text(
          t.forumNewTopic,
          style: AppTypography.h3.copyWith(fontSize: 18, color: colors.textMain),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(height: 1, color: colors.divider),

          // Scrollable form
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              children: [
                // Title
                _buildLabel(t.forumCreateTitle, colors),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  colors: colors,
                  child: TextField(
                    controller: _titleController,
                    style: AppTypography.bodyLg.copyWith(
                      color: colors.textMain,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLength: 100,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: t.forumCreateTitleHint,
                      hintStyle: AppTypography.bodyLg.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                        vertical: AppSpacing.s,
                      ),
                    ),
                  ),
                ),
                // Character count
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${_titleController.text.length}/100',
                      style: AppTypography.caption.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // University
                _buildLabel(t.forumCreateUniversity, colors),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  colors: colors,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedUniversity,
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(Icons.school_outlined, size: 20, color: colors.textSubtle),
                            const SizedBox(width: AppSpacing.s),
                            Text(
                              t.forumCreateUniversityHint,
                              style: AppTypography.bodyMd.copyWith(
                                color: colors.textSubtle.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSubtle),
                        dropdownColor: colors.surfaceVariant,
                        style: AppTypography.bodyMd.copyWith(color: colors.textMain),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.m,
                          vertical: AppSpacing.xxs,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        items: _universities.map((uni) {
                          return DropdownMenuItem(
                            value: uni,
                            child: Text(uni),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedUniversity = value);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // Content
                _buildLabel(t.forumCreateContent, colors),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  colors: colors,
                  child: TextField(
                    controller: _contentController,
                    style: AppTypography.bodyMd.copyWith(color: colors.textMain),
                    maxLines: 6,
                    minLines: 6,
                    maxLength: 2000,
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: t.forumCreateContentHint,
                      hintStyle: AppTypography.bodyMd.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: const EdgeInsets.all(AppSpacing.m),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${_contentController.text.length}/2000',
                      style: AppTypography.caption.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // Tags
                Row(
                  children: [
                    _buildLabel(t.forumCreateTags, colors),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      t.forumCreateTagsHelper,
                      style: AppTypography.caption.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  colors: colors,
                  child: TextField(
                    controller: _tagController,
                    style: AppTypography.bodyMd.copyWith(color: colors.textMain),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addTag(),
                    decoration: InputDecoration(
                      hintText: t.forumCreateTagHint,
                      hintStyle: AppTypography.bodyMd.copyWith(
                        color: colors.textSubtle.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.m, right: 4),
                        child: Text(
                          '#',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      suffixIcon: _tags.length < 5
                          ? GestureDetector(
                              onTap: _addTag,
                              child: Container(
                                margin: const EdgeInsets.only(right: AppSpacing.xs),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(AppRadius.sm),
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: colors.primary,
                                  size: 20,
                                ),
                              ),
                            )
                          : null,
                      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                        vertical: AppSpacing.s,
                      ),
                    ),
                  ),
                ),
                if (_tags.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.s),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: _tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 6,
                          top: 6,
                          bottom: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.circular),
                          border: Border.all(
                            color: colors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '#$tag',
                              style: AppTypography.bodySm.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _removeTag(tag),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 14,
                                  color: colors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),

          // Bottom submit button
          Container(
            padding: EdgeInsets.only(
              left: AppSpacing.l,
              right: AppSpacing.l,
              top: AppSpacing.m,
              bottom: bottomInset > 0 ? AppSpacing.m : AppSpacing.l + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: colors.background,
              border: Border(top: BorderSide(color: colors.divider)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: _isFormValid
                      ? LinearGradient(
                          colors: [colors.primary, colors.accent],
                        )
                      : null,
                  color: _isFormValid ? null : colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    onTap: _isFormValid ? _submitTopic : null,
                    child: Center(
                      child: Text(
                        t.forumShareTopic,
                        style: AppTypography.bodyLg.copyWith(
                          color: _isFormValid ? Colors.white : colors.textSubtle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, AppColorsExtension colors) {
    return Text(
      text,
      style: AppTypography.bodySm.copyWith(
        fontWeight: FontWeight.w600,
        color: colors.textSubtle,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildInputContainer({required AppColorsExtension colors, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: child,
    );
  }
}
