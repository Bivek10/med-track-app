import 'package:equatable/equatable.dart';

class MedicineEntity extends Equatable {
  final int id;
  final String name;
  final String dosage;
  final String unit;
  final String form;
  final String frequencyType;
  final List<int> daysOfWeek;
  final List<String> reminderTimes;
  final String? instructions;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.dosage,
    required this.unit,
    required this.form,
    required this.frequencyType,
    required this.daysOfWeek,
    required this.reminderTimes,
    this.instructions,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        dosage,
        unit,
        form,
        frequencyType,
        daysOfWeek,
        reminderTimes,
        instructions,
        status,
        createdAt,
        updatedAt,
      ];
}
