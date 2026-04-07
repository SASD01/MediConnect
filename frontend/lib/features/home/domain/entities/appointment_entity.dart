class AppointmentEntity {
  final String id;
  final String title;
  final String doctorName;
  final String location;
  final DateTime date;
  final String status;

  const AppointmentEntity({
    required this.id,
    required this.title,
    required this.doctorName,
    required this.location,
    required this.date,
    required this.status,
  });

  // Mock data para pruebas
  static AppointmentEntity get mockNextVisit => AppointmentEntity(
    id: '1',
    title: 'Cardiology Consultation',
    doctorName: 'Dr. Sarah Wilson',
    location: 'Heart Center Downtown',
    date: DateTime.now().add(const Duration(days: 2, hours: 2)),
    status: 'CONFIRMED',
  );
}
