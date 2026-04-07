import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../widgets/onboarding_page_layout.dart';

class OnboardingOnePage extends StatelessWidget {
  const OnboardingOnePage({
    super.key,
    this.onSkip,
    this.onNext,
  });

  final VoidCallback? onSkip;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      imageAsset: AppAssets.doctorIllustration,
      title: 'Your health, in one place.',
      description:
          'Your health, your appointments, and your latest visit summary-right where you need them.',
      currentPage: 0,
      totalPages: 3,
      onSkip: onSkip ?? () {},
      onNext: onNext ?? () {},
    );
  }
}
