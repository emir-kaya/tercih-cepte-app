import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Delaying the focus slightly ensures the route transition completes
    // before the keyboard pops up, resulting in a smoother animation.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textMain, size: 20),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.m),
          child: AppTextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            hintText: t.searchHint,
            prefixIcon: Icon(Icons.search_rounded, color: colors.textSubtle),
            suffixIcon: IconButton(
              icon: Icon(Icons.close_rounded, color: colors.textSubtle),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.m),
            Text(
              t.searchTitle,
              style: AppTypography.h3.copyWith(fontSize: 16, color: colors.textMain),
            ),
            const SizedBox(height: AppSpacing.m),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) => Divider(height: 1, color: colors.border),
                itemBuilder: (context, index) {
                  final mockSearches = ['Boğaziçi Bilgisayar', 'ODTÜ Yurtları', 'TYT Matematik'];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.history_rounded, color: colors.textSubtle),
                    title: Text(mockSearches[index], style: AppTypography.bodyMd.copyWith(color: colors.textMain)),
                    trailing: Icon(Icons.north_west_rounded, color: colors.textSubtle, size: 16),
                    onTap: () {
                      _searchController.text = mockSearches[index];
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
