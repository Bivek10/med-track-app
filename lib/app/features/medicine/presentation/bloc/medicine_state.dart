part of 'medicine_bloc.dart';

sealed class MedicineState extends Equatable {
  const MedicineState();

  @override
  List<Object?> get props => [];
}

final class MedicineInitial extends MedicineState {
  const MedicineInitial();
}

final class MedicineLoading extends MedicineState {
  const MedicineLoading();
}

final class MedicineLoaded extends MedicineState {
  final List<MedicineEntity> medicines;
  final bool hasMore;
  final int page;

  const MedicineLoaded({
    required this.medicines,
    required this.hasMore,
    required this.page,
  });

  @override
  List<Object?> get props => [medicines, hasMore, page];
}

final class MedicineActionInProgress extends MedicineState {
  const MedicineActionInProgress();
}

final class MedicineActionSuccess extends MedicineState {
  final String message;
  const MedicineActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class MedicineFailure extends MedicineState {
  final String message;
  const MedicineFailure(this.message);

  @override
  List<Object?> get props => [message];
}
