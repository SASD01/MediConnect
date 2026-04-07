import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/onboarding/presentation/pages/onboarding_one_page.dart';
import '../features/onboarding/presentation/pages/onboarding_three_page.dart';
import '../features/onboarding/presentation/pages/onboarding_two_page.dart';

class MediConnectApp extends StatelessWidget {
  const MediConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const _OnboardingEntryPage(),
    );
  }
}

class _OnboardingEntryPage extends StatelessWidget {
  const _OnboardingEntryPage();

  void _goToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  void _goToOnboardingThree(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingThreePage(
          onAnimationCompleted: () => _goToLogin(context),
        ),
      ),
    );
  }

  void _goToOnboardingTwo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingTwoPage(
          onSkip: () => _goToLogin(context),
          onNext: () => _goToOnboardingThree(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingOnePage(
      onSkip: () => _goToLogin(context),
      onNext: () => _goToOnboardingTwo(context),
    );
  }
}
