import 'package:equatable/equatable.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class LoadReportsEvent extends ReportsEvent {
  final String period;

  const LoadReportsEvent({this.period = 'weekly'});

  @override
  List<Object?> get props => [period];
}
