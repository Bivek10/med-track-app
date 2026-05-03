import 'package:equatable/equatable.dart';

class IntakeEntity extends Equatable {
  final int id;
  final String medicineName;
  final String dosage;
  final String? instruction;
  final String time; // e.g. '08:00 AM'
  final String status; // 'pending', 'taken', 'missed', 'snoozed'

  const IntakeEntity({
    required this.id,
    required this.medicineName,
    required this.dosage,
    this.instruction,
    required this.time,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        medicineName,
        dosage,
        instruction,
        time,
        status,
      ];
}
