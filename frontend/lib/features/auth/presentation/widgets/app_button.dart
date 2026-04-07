import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum _AppButtonVariant { primary, social, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final _AppButtonVariant _variant;
  final Widget? icon;

  const AppButton._({
    required this.text,
    required this.onPressed,
    required _AppButtonVariant variant,
    this.icon,
  }) : _variant = variant;

  /// Primary solid blue button
  factory AppButton.primary({
    required String text,
    required VoidCallback onPressed,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      variant: _AppButtonVariant.primary,
    );
  }

  /// Outlined button for social auth actions, supports prefix icons
  factory AppButton.social({
    required String text,
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return AppButton._(
      text: text,
      icon: icon,
      onPressed: onPressed,
      variant: _AppButtonVariant.social,
    );
  }

  /// Text-only interactive button link
  factory AppButton.text({
    required String text,
    required VoidCallback onPressed,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      variant: _AppButtonVariant.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_variant) {
      case _AppButtonVariant.primary:
        return _buildPrimaryButton();
      case _AppButtonVariant.social:
        return _buildSocialButton();
      case _AppButtonVariant.text:
        return _buildTextButton();
    }
  }

  Widget _buildPrimaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onboardingThreeBackground,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.title,
          elevation: 0,
          side: const BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.onboardingThreeBackground,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
