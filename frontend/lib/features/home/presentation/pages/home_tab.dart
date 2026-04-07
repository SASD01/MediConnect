import 'package:flutter/material.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/clinical_record_entity.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/clinical_record_tile.dart';
import '../widgets/home_header.dart';
import '../widgets/next_visit_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mockAppointment = AppointmentEntity.mockNextVisit;
    final mockRecords = ClinicalRecordEntity.mockRecords;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeHeader(),

            NextVisitCard(appointment: mockAppointment),
            const SizedBox(height: 24),

            BookAppointmentButton(
              onPressed: () {
                // TODO: Navigate to Booking Flow
              },
            ),
            const SizedBox(height: 32),

            const Text(
              'CLINICAL RECORDS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9CA3AF),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),

            ...mockRecords.map(
              (record) => ClinicalRecordTile(
                record: record,
                onTap: () {
                  // TODO: Navigate to detail
                },
              ),
            ),

            // Spacing to account for the bottom nav bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
