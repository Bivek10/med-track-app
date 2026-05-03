import 'package:equatable/equatable.dart';

class AdherenceReportEntity extends Equatable {
  final String period;
  final double overallAdherencePercentage;
  final int totalScheduled;
  final int totalTaken;
  final int totalMissed;
  final List<DailyBreakdownEntity> dailyBreakdown;

  const AdherenceReportEntity({
    required this.period,
    required this.overallAdherencePercentage,
    required this.totalScheduled,
    required this.totalTaken,
    required this.totalMissed,
    required this.dailyBreakdown,
  });

  @override
  List<Object?> get props => [
        period,
        overallAdherencePercentage,
        totalScheduled,
        totalTaken,
        totalMissed,
        dailyBreakdown,
      ];
}

class DailyBreakdownEntity extends Equatable {
  final String date;
  final int taken;
  final int missed;

  const DailyBreakdownEntity({
    required this.date,
    required this.taken,
    required this.missed,
  });

  @override
  List<Object?> get props => [date, taken, missed];
}
