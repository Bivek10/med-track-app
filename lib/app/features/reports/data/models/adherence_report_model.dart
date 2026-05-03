import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/adherence_report_entity.dart';

class AdherenceReportModel {
  final String period;
  final double overallAdherencePercentage;
  final int totalScheduled;
  final int totalTaken;
  final int totalMissed;
  final List<DailyBreakdownModel> dailyBreakdown;

  AdherenceReportModel({
    required this.period,
    required this.overallAdherencePercentage,
    required this.totalScheduled,
    required this.totalTaken,
    required this.totalMissed,
    required this.dailyBreakdown,
  });

  factory AdherenceReportModel.fromJson(JsonMap json) {
    return AdherenceReportModel(
      period: json['period'] as String? ?? 'weekly',
      overallAdherencePercentage: (json['overallAdherencePercentage'] as num? ?? 0).toDouble(),
      totalScheduled: json['totalScheduled'] as int? ?? 0,
      totalTaken: json['totalTaken'] as int? ?? 0,
      totalMissed: json['totalMissed'] as int? ?? 0,
      dailyBreakdown: (json['dailyBreakdown'] as List? ?? [])
          .map((e) => DailyBreakdownModel.fromJson(e as JsonMap))
          .toList(),
    );
  }

  AdherenceReportEntity toEntity() {
    return AdherenceReportEntity(
      period: period,
      overallAdherencePercentage: overallAdherencePercentage,
      totalScheduled: totalScheduled,
      totalTaken: totalTaken,
      totalMissed: totalMissed,
      dailyBreakdown: dailyBreakdown.map((e) => e.toEntity()).toList(),
    );
  }
}

class DailyBreakdownModel {
  final String date;
  final int taken;
  final int missed;

  DailyBreakdownModel({
    required this.date,
    required this.taken,
    required this.missed,
  });

  factory DailyBreakdownModel.fromJson(JsonMap json) {
    return DailyBreakdownModel(
      date: json['date'] as String? ?? '',
      taken: json['taken'] as int? ?? 0,
      missed: json['missed'] as int? ?? 0,
    );
  }

  DailyBreakdownEntity toEntity() {
    return DailyBreakdownEntity(
      date: date,
      taken: taken,
      missed: missed,
    );
  }
}
