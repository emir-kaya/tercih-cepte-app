import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_toast.dart';

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

  void _submitTopic() {
    if (!_isFormValid) return;

    // TODO: Connect to BLoC / use case
    context.pop();
    AppToast.show(
      context,
      message: 'Konu başarıyla oluşturuldu!',
      type: AppToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textMain),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Yeni Konu',
          style: AppTypography.h3.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: AppColors.divider),

          // Scrollable form
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              children: [
                // Title
                _buildLabel('Başlık'),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  child: TextField(
                    controller: _titleController,
                    style: AppTypography.bodyLg.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLength: 100,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Konunun başlığını yazın...',
                      hintStyle: AppTypography.bodyLg.copyWith(
                        color: AppColors.textSubtle.withValues(alpha: 0.6),
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
                        color: AppColors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // University
                _buildLabel('Üniversite'),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedUniversity,
                        isExpanded: true,
                        hint: Row(
                          children: [
                            const Icon(Icons.school_outlined, size: 20, color: AppColors.textSubtle),
                            const SizedBox(width: AppSpacing.s),
                            Text(
                              'Üniversite seçin',
                              style: AppTypography.bodyMd.copyWith(
                                color: AppColors.textSubtle.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSubtle),
                        dropdownColor: AppColors.surfaceVariant,
                        style: AppTypography.bodyMd.copyWith(color: AppColors.textMain),
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
                _buildLabel('İçerik'),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  child: TextField(
                    controller: _contentController,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.textMain),
                    maxLines: 6,
                    minLines: 6,
                    maxLength: 2000,
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Düşüncelerinizi, sorularınızı detaylı bir şekilde yazın...',
                      hintStyle: AppTypography.bodyMd.copyWith(
                        color: AppColors.textSubtle.withValues(alpha: 0.6),
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
                        color: AppColors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // Tags
                Row(
                  children: [
                    _buildLabel('Etiketler'),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '(isteğe bağlı, en fazla 5)',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                _buildInputContainer(
                  child: TextField(
                    controller: _tagController,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.textMain),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addTag(),
                    decoration: InputDecoration(
                      hintText: 'Etiket yazın...',
                      hintStyle: AppTypography.bodyMd.copyWith(
                        color: AppColors.textSubtle.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: AppSpacing.m, right: 4),
                        child: Text(
                          '#',
                          style: TextStyle(
                            color: AppColors.primary,
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
                                  color: AppColors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(AppRadius.sm),
                                ),
                                child: const Icon(
                                  Icons.add_rounded,
                                  color: AppColors.primary,
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
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.circular),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '#$tag',
                              style: AppTypography.bodySm.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _removeTag(tag),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 14,
                                  color: AppColors.primary,
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
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: _isFormValid
                      ? const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        )
                      : null,
                  color: _isFormValid ? null : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    onTap: _isFormValid ? _submitTopic : null,
                    child: Center(
                      child: Text(
                        'Konuyu Paylaş',
                        style: AppTypography.bodyLg.copyWith(
                          color: _isFormValid ? Colors.white : AppColors.textSubtle,
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.bodySm.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textSubtle,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
