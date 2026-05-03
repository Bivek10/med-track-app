import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/intake_entity.dart';
import '../../domain/usecases/dashboard_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardUsecase _usecase;

  DashboardBloc(this._usecase) : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<UpdateIntakeStatusEvent>(_onUpdateIntakeStatus);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final intakesResult = await _usecase.getTodaysIntakes();
    final adherenceResult = await _usecase.getAdherence();

    intakesResult.fold(
      (failure) => emit(DashboardError(message: "Failed to load today's intakes")),
      (intakes) {
        adherenceResult.fold(
          (failure) => emit(DashboardError(message:"Failed to load adherence data")),
          (adherence) {
            emit(DashboardLoaded(intakes: intakes, adherence: adherence));
          },
        );
      },
    );
  }

  Future<void> _onUpdateIntakeStatus(
    UpdateIntakeStatusEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      // Optimistic update
      final updatedIntakes = currentState.intakes.map((intake) {
        if (intake.id == event.id) {
          return IntakeEntity(
            id: intake.id,
            medicineName: intake.medicineName,
            dosage: intake.dosage,
            instruction: intake.instruction,
            time: intake.time,
            status: event.status,
          );
        }
        return intake;
      }).toList();
      
      emit(DashboardLoaded(
        intakes: updatedIntakes,
        adherence: currentState.adherence,
      ));

      final result = await _usecase.updateIntakeStatus(event.id, event.status);
      result.fold(
        (failure) {
          // Revert on failure
          emit(currentState);
          emit(DashboardError(message: "Failed to update intake status"));
          emit(currentState); // Re-emit loaded state after showing error
        },
        (_) {
          // Refresh the data to get accurate adherence stats
          add(LoadDashboardData());
        },
      );
    }
  }
}
