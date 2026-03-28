import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/medicine_entity.dart';

class MedicineModel {
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

  MedicineModel({
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

  factory MedicineModel.fromJson(JsonMap json) {
    return MedicineModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      dosage: json['dosage']?.toString() ?? "",
      unit: json['unit'] as String? ?? "",
      form: json['form'] as String? ?? "",
      frequencyType: json['frequencyType'] as String? ?? "",
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      reminderTimes: (json['reminderTimes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      instructions: json['instructions'] as String?,
      status: json['status'] as String? ?? "active",
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  JsonMap toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'unit': unit,
      'form': form,
      'frequencyType': frequencyType,
      'daysOfWeek': daysOfWeek,
      'reminderTimes': reminderTimes,
      'instructions': instructions,
      'status': status,
    };
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      name: name,
      dosage: dosage,
      unit: unit,
      form: form,
      frequencyType: frequencyType,
      daysOfWeek: daysOfWeek,
      reminderTimes: reminderTimes,
      instructions: instructions,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class MedicineListResponseModel {
  final List<MedicineModel> medicines;
  final int total;
  final int limit;
  final int page;

  MedicineListResponseModel({
    required this.medicines,
    required this.total,
    required this.limit,
    required this.page,
  });

  factory MedicineListResponseModel.fromJson(JsonMap json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return MedicineListResponseModel(
      medicines: data.map((e) => MedicineModel.fromJson(e as JsonMap)).toList(),
      total: json['total'] as int? ?? 0,
      limit: json['limit'] as int? ?? 10,
      page: json['page'] as int? ?? 1,
    );
  }
}
