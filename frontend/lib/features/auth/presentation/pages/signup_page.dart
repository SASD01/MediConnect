import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/signup_form.dart';
import '../widgets/social_auth_section.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    Future<void> handleSignupSubmitted({
      required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
    }) async {
      final success = await ref
          .read(authProvider.notifier)
          .register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            password: password,
          );

      if (success) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro exitoso. Puedes iniciar sesión.'),
          ),
        );
        Navigator.pop(context); // Vuelve al login
      } else {
        if (!context.mounted) return;
        final error = ref.read(authProvider).error ?? 'Error de registro';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeader(title: 'Sign Up'),
                  const SizedBox(height: 24),

                  SignupForm(onSignupSubmitted: handleSignupSubmitted),
                  const SizedBox(height: 20),

                  _buildLoginLink(context),
                  const SizedBox(height: 32),

                  const SocialAuthSection(isSignUp: true),
                ],
              ),
            ),
            if (authState.isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.title,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppButton.text(
          text: 'Log In',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
