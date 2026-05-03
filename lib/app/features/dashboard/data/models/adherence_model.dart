import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/adherence_entity.dart';

class AdherenceModel {
  final int takenCount;
  final int totalCount;
  final String message;

  AdherenceModel({
    required this.takenCount,
    required this.totalCount,
    required this.message,
  });

  factory AdherenceModel.fromJson(JsonMap json) {
    final data = json['data'] != null ? json['data'] as Map<String, dynamic> : json;
    
    return AdherenceModel(
      takenCount: data['takenCount'] as int? ?? 0,
      totalCount: data['totalCount'] as int? ?? 0,
      message: data['message'] as String? ?? "No data",
    );
  }

  AdherenceEntity toEntity() {
    return AdherenceEntity(
      takenCount: takenCount,
      totalCount: totalCount,
      message: message,
    );
  }
}
