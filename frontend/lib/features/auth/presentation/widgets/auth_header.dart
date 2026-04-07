import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  const AuthHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        
        // Circular Logo Icon using defined Material Symbol
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: AppColors.onboardingThreeBackground,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Symbols.ecg_heart,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // App Name
        const Text(
          'MediConnect',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        const SizedBox(height: 32),
        
        // Contextual Title
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.title,
            ),
          ),
        ),
      ],
    );
  }
}
