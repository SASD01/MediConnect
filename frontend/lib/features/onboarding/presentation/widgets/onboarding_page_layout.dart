import 'package:flutter/material.dart';

import 'onboarding_bottom_bar.dart';

class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
    required this.onNext,
    this.imageWidth = 330,
  });

  final String imageAsset;
  final String title;
  final String description;
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Center(
                child: Text(
                  'MediConnect',
                  style: textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          imageAsset,
                          width: imageWidth,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      description,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 34),
                    OnboardingBottomBar(
                      currentPage: currentPage,
                      totalPages: totalPages,
                      onSkip: onSkip,
                      onNext: onNext,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
