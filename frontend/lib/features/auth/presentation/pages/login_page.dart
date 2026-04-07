import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../pages/signup_page.dart';
import '../../../home/presentation/pages/main_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/login_form.dart';
import '../widgets/social_auth_section.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    Future<void> handleLoginSubmitted(String email, String password) async {
      final success = await ref.read(authProvider.notifier).login(email, password);

      if (success) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesión iniciada correctamente')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        if (!context.mounted) return;
        final error = ref.read(authProvider).error ?? 'Error de inicio de sesión';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeader(title: 'Sign In'),
                  const SizedBox(height: 24),

                  LoginForm(onLoginSubmitted: handleLoginSubmitted),
                  const SizedBox(height: 20),

                  _buildRegistrationLink(context),
                  const SizedBox(height: 32),

                  const SocialAuthSection(isSignUp: false),
                ],
              ),
            ),
            if (authState.isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'New user? ',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.title,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppButton.text(
          text: 'Create account',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
