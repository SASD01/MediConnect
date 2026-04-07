import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class BookAppointmentButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BookAppointmentButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF), // Light blue background
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0xFFD1E4FF)), // Subtle blue border
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Book new appointment ticket',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
