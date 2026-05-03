import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_reports_usecase.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetReportsUseCase _usecase;

  ReportsBloc(this._usecase) : super(ReportsInitial()) {
    on<LoadReportsEvent>(_onLoadReports);
  }

  Future<void> _onLoadReports(
    LoadReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(ReportsLoading());

    final adherenceResult = await _usecase.getAdherenceReport(event.period);
    final missedDosesResult = await _usecase.getMissedDoses();

    adherenceResult.fold(
      (failure) => emit(ReportsError(message: failure.message)),
      (adherenceReport) {
        missedDosesResult.fold(
          (failure) => emit(ReportsError(message: failure.message)),
          (missedDoses) {
            emit(ReportsLoaded(
              adherenceReport: adherenceReport,
              missedDoses: missedDoses,
            ));
          },
        );
      },
    );
  }
}
