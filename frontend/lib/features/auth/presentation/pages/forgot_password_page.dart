import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 120, // Espacio suficiente para la flecha y el texto
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent, // Asegura que todo el área sea tocable
            child: const Row(
              children: [
                SizedBox(width: 24),
                Icon(Icons.arrow_back, color: AppColors.title, size: 20),
                SizedBox(width: 6),
                Text(
                  'Go Back',
                  style: TextStyle(
                    color: AppColors.title,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(title: 'Reset Password'),
              const SizedBox(height: 8),
              
              const Text(
                'Please enter your email address. You will receive a code to create a new password.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontFamily: 'SF Pro Display', // Letra común o la del theme
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              
              CustomTextField(
                controller: _emailController,
                hintText: 'johndoe@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              
              AppButton.primary(
                text: 'SEND CODE',
                onPressed: () {
                  // TODO: Enviar código
                  FocusScope.of(context).unfocus();
                  if (_emailController.text.trim().isEmpty) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código enviado al correo.')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
