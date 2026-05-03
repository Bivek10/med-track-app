import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends DashboardEvent {}

class UpdateIntakeStatusEvent extends DashboardEvent {
  final int id;
  final String status;

  const UpdateIntakeStatusEvent({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];
}
