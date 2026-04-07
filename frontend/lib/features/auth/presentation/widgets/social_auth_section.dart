import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_button.dart';
import '../providers/auth_provider.dart';
import '../../../home/presentation/pages/main_screen.dart';

class SocialAuthSection extends ConsumerWidget {
  final bool isSignUp;

  const SocialAuthSection({super.key, this.isSignUp = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefixText = isSignUp ? 'Sign Up' : 'Sign in';

    return Column(
      children: [
        _buildDivider(),
        const SizedBox(height: 32),

        AppButton.social(
          text: '$prefixText with Google',
          icon: SvgPicture.asset(
            'assets/images/google.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () async {
            final success = await ref
                .read(authProvider.notifier)
                .loginWithGoogle();

            if (success) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bienvenido a MediConnect')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            } else {
              if (!context.mounted) return;
              final authState = ref.read(authProvider);
              if (authState.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
      ],
    );
  }
}
