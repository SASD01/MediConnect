import 'package:flutter/material.dart';

import '../pages/forgot_password_page.dart';
import 'app_button.dart';
import 'custom_text_field.dart';

class LoginForm extends StatefulWidget {
  /// Defines the event emitted when the user tries to authenticate.
  final Future<void> Function(String email, String password) onLoginSubmitted;

  const LoginForm({super.key, required this.onLoginSubmitted});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  Future<void> _handleSubmission() async {
    final email = _emailInputController.text;
    final password = _passwordInputController.text;

    if (email.isEmpty || password.isEmpty) return;

    FocusScope.of(context).unfocus();

    await widget.onLoginSubmitted(email, password);
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _emailInputController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: _passwordInputController,
          hintText: 'Password',
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF6B7280), // Gris tipo link
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        AppButton.primary(text: 'SIGN IN', onPressed: _handleSubmission),
      ],
    );
  }
}
