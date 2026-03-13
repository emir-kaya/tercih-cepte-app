import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardDotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive ? AppColors.primary : AppColors.surfaceHighlight,
          ),
        );
      }),
    );
  }
}
