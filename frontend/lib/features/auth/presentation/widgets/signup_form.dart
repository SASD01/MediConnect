import 'package:flutter/material.dart';

import 'app_button.dart';
import 'custom_text_field.dart';

class SignupForm extends StatefulWidget {
  /// Defines the event emitted when the user tries to create an account.
  final Future<void> Function({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  })
  onSignupSubmitted;

  const SignupForm({super.key, required this.onSignupSubmitted});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _firstNameInputController = TextEditingController();
  final _lastNameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _phoneInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  bool _isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>\-_\]\[]'))) return false;
    return true;
  }

  /// Isolating form state behavior from parent
  Future<void> _handleSubmission() async {
    final firstName = _firstNameInputController.text.trim();
    final lastName = _lastNameInputController.text.trim();
    final email = _emailInputController.text.trim();
    final phone = _phoneInputController.text.trim();
    final password = _passwordInputController.text;

    // Perform basic local validation
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor llena todos los campos necesarios.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!_isPasswordStrong(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Tu contraseña debe tener min. 8 caracteres e incluir mayúsculas, minúsculas, números y un carácter especial.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    // Bubble up to coordinator
    await widget.onSignupSubmitted(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  void dispose() {
    _firstNameInputController.dispose();
    _lastNameInputController.dispose();
    _emailInputController.dispose();
    _phoneInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _firstNameInputController,
                hintText: 'First name',
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: _lastNameInputController,
                hintText: 'Last name',
                keyboardType: TextInputType.name,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: _emailInputController,
          hintText: 'email@domain.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: _phoneInputController,
          hintText: 'Phone number',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: _passwordInputController,
          hintText: '*****************',
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 24),

        AppButton.primary(text: 'CREATE ACCOUNT', onPressed: _handleSubmission),
      ],
    );
  }
}
