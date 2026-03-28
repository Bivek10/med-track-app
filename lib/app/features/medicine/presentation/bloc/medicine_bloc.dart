import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/medicine_entity.dart';
import '../../domain/usecases/medicine_usecase.dart';

part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final MedicineUsecase _medicineUsecase;

  MedicineBloc(this._medicineUsecase) : super(const MedicineInitial()) {
    on<FetchMedicines>(_onFetchMedicines);
    on<AddMedicine>(_onAddMedicine);
    on<UpdateMedicine>(_onUpdateMedicine);
    on<DeleteMedicine>(_onDeleteMedicine);
  }

  Future<void> _onFetchMedicines(
    FetchMedicines event,
    Emitter<MedicineState> emit,
  ) async {
    final currentState = state;
    int currentPage = 1;
    List<MedicineEntity> currentMedicines = [];

    if (event.refresh) {
      emit(const MedicineLoading());
    } else if (currentState is MedicineLoaded) {
      if (!currentState.hasMore) return;
      currentPage = currentState.page + 1;
      currentMedicines = currentState.medicines;
    } else {
      emit(const MedicineLoading());
    }

    final result = await _medicineUsecase.callGetMedicines(
      limit: 10,
      page: currentPage,
      orderBy: event.orderBy,
    );

    result.fold(
      (l) => emit(MedicineFailure(l.message)),
      (r) {
        final newMedicines = r.data;
        final allMedicines =
            event.refresh ? newMedicines : [...currentMedicines, ...newMedicines];
        final hasMore = newMedicines.length == 10;

        emit(MedicineLoaded(
          medicines: allMedicines,
          hasMore: hasMore,
          page: currentPage,
        ));
      },
    );
  }

  Future<void> _onAddMedicine(
    AddMedicine event,
    Emitter<MedicineState> emit,
  ) async {
    emit(const MedicineActionInProgress());
    final result = await _medicineUsecase.callCreateMedicine(event.data);

    result.fold(
      (l) => emit(MedicineFailure(l.message)),
      (r) {
        emit(const MedicineActionSuccess("Medicine added successfully"));
        add(const FetchMedicines(refresh: true));
      },
    );
  }

  Future<void> _onUpdateMedicine(
    UpdateMedicine event,
    Emitter<MedicineState> emit,
  ) async {
    emit(const MedicineActionInProgress());
    final result =
        await _medicineUsecase.callUpdateMedicine(event.id, event.data);

    result.fold(
      (l) => emit(MedicineFailure(l.message)),
      (r) {
        emit(const MedicineActionSuccess("Medicine updated successfully"));
        add(const FetchMedicines(refresh: true));
      },
    );
  }

  Future<void> _onDeleteMedicine(
    DeleteMedicine event,
    Emitter<MedicineState> emit,
  ) async {
    emit(const MedicineActionInProgress());
    final result = await _medicineUsecase.callDeleteMedicine(event.id);

    result.fold(
      (l) => emit(MedicineFailure(l.message)),
      (r) {
        emit(const MedicineActionSuccess("Medicine deleted successfully"));
        add(const FetchMedicines(refresh: true));
      },
    );
  }
}
