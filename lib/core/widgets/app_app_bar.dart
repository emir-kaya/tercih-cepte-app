import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../theme/app_typography.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AppBar(
      title: Text(
        title,
        style: AppTypography.h3.copyWith(color: colors.textMain),
      ),
      actions: actions,
      centerTitle: centerTitle,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
