import 'package:equatable/equatable.dart';
import '../../domain/entities/adherence_report_entity.dart';
import '../../domain/entities/missed_dose_entity.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final AdherenceReportEntity adherenceReport;
  final List<MissedDoseEntity> missedDoses;

  const ReportsLoaded({
    required this.adherenceReport,
    required this.missedDoses,
  });

  @override
  List<Object?> get props => [adherenceReport, missedDoses];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError({required this.message});

  @override
  List<Object?> get props => [message];
}
