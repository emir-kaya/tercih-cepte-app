import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class AppChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? textColor;

  const AppChip({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final bgColor = isSelected
        ? colors.primary
        : (backgroundColor ?? colors.surfaceVariant);

    final txtColor = isSelected
        ? colors.textInverse
        : (textColor ?? colors.textMain);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.bodySm.copyWith(
            color: txtColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
