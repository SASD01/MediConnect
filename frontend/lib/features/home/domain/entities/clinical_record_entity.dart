class ClinicalRecordEntity {
  final String id;
  final String title;
  final String subtitle;
  final String type;

  const ClinicalRecordEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  static List<ClinicalRecordEntity> get mockRecords => [
    const ClinicalRecordEntity(
      id: '1',
      title: 'Clinical Notes',
      subtitle: 'Updated 2 days ago',
      type: 'notes',
    ),
    const ClinicalRecordEntity(
      id: '2',
      title: 'Visit History',
      subtitle: 'Archive of all appointments',
      type: 'history',
    ),
  ];
}
