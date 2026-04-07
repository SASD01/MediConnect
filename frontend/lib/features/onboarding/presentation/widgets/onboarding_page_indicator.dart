import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  final int currentIndex;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    final safeIndex = currentIndex.clamp(0, totalPages - 1).toInt();

    return Row(
      children: List.generate(totalPages, (index) {
        final isActive = index == safeIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(right: index == totalPages - 1 ? 0 : 8),
          height: 8,
          width: isActive ? 32 : 20,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.indicatorInactive,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
