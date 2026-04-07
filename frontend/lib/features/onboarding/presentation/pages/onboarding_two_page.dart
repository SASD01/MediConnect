import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../widgets/onboarding_page_layout.dart';

class OnboardingTwoPage extends StatelessWidget {
  const OnboardingTwoPage({
    super.key,
    this.onSkip,
    this.onNext,
  });

  final VoidCallback? onSkip;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      imageAsset: AppAssets.calendarIllustration,
      title: 'Book in seconds.',
      description:
          'Pick a date and time. We\'ll generate your digital ticket and send reminders before your visit.',
      currentPage: 1,
      totalPages: 3,
      onSkip: onSkip ?? () {},
      onNext: onNext ?? () {},
      imageWidth: 335,
    );
  }
}
