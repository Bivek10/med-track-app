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
    
    final taken = data['totalTaken'] as int? ?? 0;
    final scheduled = data['totalScheduled'] as int? ?? 0;
    
    String msg = "You're doing great!";
    if (scheduled > 0) {
      final left = scheduled - taken;
      msg = left > 0 ? "Only $left pill${left > 1 ? 's' : ''} left for today." : "All done for today!";
    } else {
      msg = "No medicines scheduled for today.";
    }

    return AdherenceModel(
      takenCount: taken,
      totalCount: scheduled,
      message: data['message'] as String? ?? msg,
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
