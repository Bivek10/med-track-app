import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/intake_entity.dart';

class IntakeModel {
  final int id;
  final String medicineName;
  final String dosage;
  final String? instruction;
  final String time;
  final String status;

  IntakeModel({
    required this.id,
    required this.medicineName,
    required this.dosage,
    this.instruction,
    required this.time,
    required this.status,
  });

  factory IntakeModel.fromJson(JsonMap json) {
    return IntakeModel(
      id: json['id'] as int? ?? 0,
      medicineName: json['medicineName'] as String? ?? "",
      dosage: json['dosage']?.toString() ?? "",
      instruction: json['instruction'] as String?,
      time: json['time'] as String? ?? "",
      status: json['status'] as String? ?? "pending",
    );
  }

  IntakeEntity toEntity() {
    return IntakeEntity(
      id: id,
      medicineName: medicineName,
      dosage: dosage,
      instruction: instruction,
      time: time,
      status: status,
    );
  }
}

class IntakeListResponseModel {
  final List<IntakeModel> intakes;

  IntakeListResponseModel({required this.intakes});

  factory IntakeListResponseModel.fromJson(JsonMap json) {
    // Handling if it's wrapped in `data`
    final data = json['data'] != null ? json['data'] as List<dynamic> : [];
    // If it's an array directly at root, we would handle it differently, 
    // but typically NestJS wraps it or we can fallback to json being the list itself if possible.
    // Assuming standard `{ "data": [...] }` based on MedicineModel
    return IntakeListResponseModel(
      intakes: data.map((e) => IntakeModel.fromJson(e as JsonMap)).toList(),
    );
  }
}
