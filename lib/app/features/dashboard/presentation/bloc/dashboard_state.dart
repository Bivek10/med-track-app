import 'package:equatable/equatable.dart';

import '../../domain/entities/adherence_entity.dart';
import '../../domain/entities/intake_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<IntakeEntity> intakes;
  final AdherenceEntity adherence;
  final DateTime lastUpdated;

  DashboardLoaded({
    required this.intakes,
    required this.adherence,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  @override
  List<Object?> get props => [intakes, adherence, lastUpdated];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
