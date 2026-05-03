import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/missed_dose_entity.dart';

class MissedDoseModel {
  final int id;
  final String medicineName;
  final DateTime scheduledTime;
  final String status;

  MissedDoseModel({
    required this.id,
    required this.medicineName,
    required this.scheduledTime,
    required this.status,
  });

  factory MissedDoseModel.fromJson(JsonMap json) {
    return MissedDoseModel(
      id: json['id'] as int? ?? 0,
      medicineName: json['medicineName'] as String? ?? '',
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      status: json['status'] as String? ?? 'missed',
    );
  }

  MissedDoseEntity toEntity() {
    return MissedDoseEntity(
      id: id,
      medicineName: medicineName,
      scheduledTime: scheduledTime,
      status: status,
    );
  }
}

class MissedDoseListResponseModel {
  final List<MissedDoseModel> missedDoses;

  MissedDoseListResponseModel({required this.missedDoses});

  factory MissedDoseListResponseModel.fromJson(List<dynamic> json) {
    return MissedDoseListResponseModel(
      missedDoses: json.map((e) => MissedDoseModel.fromJson(e as JsonMap)).toList(),
    );
  }
}
