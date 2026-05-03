import 'package:equatable/equatable.dart';

class MissedDoseEntity extends Equatable {
  final int id;
  final String medicineName;
  final DateTime scheduledTime;
  final String status;

  const MissedDoseEntity({
    required this.id,
    required this.medicineName,
    required this.scheduledTime,
    required this.status,
  });

  @override
  List<Object?> get props => [id, medicineName, scheduledTime, status];
}
